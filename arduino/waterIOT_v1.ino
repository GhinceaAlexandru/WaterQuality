#include <WiFi.h>
#include <Wire.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <FirebaseESP32.h>

//TDS
#define VREF 5.0              // analog reference voltage(Volt) of the ADC
#define SCOUNT  30            // sum of sample point

// Insert your network credentials
#define WIFI_SSID ""
#define WIFI_PASSWORD ""

// Firebase connections data
#define FIREBASE_HOST ""
#define FIREBASE_AUTH ""

//--------------------------------Sensor PIN------------------------------------------
#define PH_INPUT 35
#define TURB_INPUT 34
#define TEMP_INPUT 36
#define TDS_INPUT 39

//--------------------------------PH Sensor Data------------------------------------------
unsigned long int avgValue;  //Store the average value of the sensor feedback
float b;
int buf[10], temp;

//--------------------------------TURB Sensor Data------------------------------------------
float volt;
float ntu;

//--------------------------------TEMP Sensor Data------------------------------------------
OneWire oneWire(TEMP_INPUT);         // setup a oneWire instance
DallasTemperature tempSensor(&oneWire); // pass oneWire to DallasTemperature library

float tempCelsius;    // temperature in Celsius
float tempFahrenheit; // temperature in Fahrenheit

//--------------------------------TDS Sensor Data------------------------------------------
int analogBuffer[SCOUNT];     // store the analog value in the array, read from ADC
int analogBufferTemp[SCOUNT];
int analogBufferIndex = 0;
int copyIndex = 0;

float averageVoltage = 0;
float tdsValue = 0;
float temperature = 16;       // current temperature for compensation

// median filtering algorithm
int getMedianNum(int bArray[], int iFilterLen) {
  int bTab[iFilterLen];
  for (byte i = 0; i < iFilterLen; i++)
    bTab[i] = bArray[i];
  int i, j, bTemp;
  for (j = 0; j < iFilterLen - 1; j++) {
    for (i = 0; i < iFilterLen - j - 1; i++) {
      if (bTab[i] > bTab[i + 1]) {
        bTemp = bTab[i];
        bTab[i] = bTab[i + 1];
        bTab[i + 1] = bTemp;
      }
    }
  }
  if ((iFilterLen & 1) > 0) {
    bTemp = bTab[(iFilterLen - 1) / 2];
  }
  else {
    bTemp = (bTab[iFilterLen / 2] + bTab[iFilterLen / 2 - 1]) / 2;
  }
  return bTemp;
}


//--------------------------------FirebaseESP32------------------------------------------
FirebaseData firebaseData;
FirebaseJson json;


void setup() {
  wifiConnect();

  Serial.begin(115200);
  pinMode(PH_INPUT, INPUT);
  pinMode(TURB_INPUT, INPUT);
  pinMode(TDS_INPUT, INPUT);
  tempSensor.begin();

  Serial.begin(9600);
  Serial.println("Connecting Firebase.....");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseReconnect();
  Serial.println("Firebase OK.");
}

void wifiConnect() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
}
//------------------------------FB_reconnector--------------------------------------------
void firebaseReconnect()
{
  Serial.println("Trying to reconnect");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {
  PHsensor();
  TurbSensor();
  TempSensor();
  TdsSensor();
}

//--------------------------PH Sensor-----------------
void PHsensor() {
  for (int i = 0; i < 10; i++) //Get 10 sample value from the sensor for smooth the value
  {
    buf[i] = analogRead(PH_INPUT);
    delay(10);
  }
  for (int i = 0; i < 9; i++) //sort the analog from small to large
  {
    for (int j = i + 1; j < 10; j++)
    {
      if (buf[i] > buf[j])
      {
        temp = buf[i];
        buf[i] = buf[j];
        buf[j] = temp;
      }
    }
  }
  avgValue = 0;
  for (int i = 2; i < 8; i++)               //take the average value of 6 center sample
    avgValue += buf[i];
  float phValue = (float)avgValue * 5.0 / 1024 / 6; //convert the analog into millivolt
  phValue = 3.5 * phValue;                  //convert the millivolt into pH value
  Serial.print("    pH:");
  Serial.print(phValue, 2);

  //-------------------------- Sensor data on firebase-----------------
  if (Firebase.setFloat(firebaseData, "sensor_data/pH", phValue)) {
    Serial.println("PH Value");
  } else {
    Serial.println("PH Value error");
    Serial.println("Error: " + firebaseData.errorReason());
  }
}

void TurbSensor() {
  volt = 0;
  for (int i = 0; i < 800; i++)
  {
    volt += ((float)analogRead(TURB_INPUT) / 1023) * 5;
  }
  volt = volt / 800;
  volt = round_to_dp(volt, 2);
  if (volt < 2.5) {
    ntu = 3000;
  } else {
    ntu = -1120.4 * sq(volt) + 5742.3 * volt - 4353.8;
  }

  //-------------------------- Sensor data on firebase-----------------
  if (Firebase.setFloat(firebaseData, "sensor_data/Turbidity_volt", volt)) {
    Serial.println(" V");
  } else {
    Serial.println("V error");
    Serial.println("Error: " + firebaseData.errorReason());
  }
  if (Firebase.setFloat(firebaseData, "sensor_data/Turbidity", ntu)) {
    Serial.println("NTU Value");
  } else {
    Serial.println("NTU Value error");
    Serial.println("Error: " + firebaseData.errorReason());
  }
  delay(10);
}

float round_to_dp( float in_value, int decimal_place )
{
  float multiplier = powf( 10.0f, decimal_place );
  in_value = roundf( in_value * multiplier ) / multiplier;
  return in_value;
}

void TempSensor() {
  tempSensor.requestTemperatures();             // send the command to get temperatures
  tempCelsius = tempSensor.getTempCByIndex(0);  // read temperature in Celsius
  tempFahrenheit = tempCelsius * 9 / 5 + 32; // convert Celsius to Fahrenheit

  Serial.print("Temperature: ");
  Serial.print(tempCelsius);    // print the temperature in Celsius
  Serial.print("°C");
  Serial.print("  ~  ");        // separator between Celsius and Fahrenheit
  Serial.print(tempFahrenheit); // print the temperature in Fahrenheit
  Serial.println("°F");

  if (Firebase.setFloat(firebaseData, "sensor_data/temperature", tempCelsius)) {
    Serial.println("°C Value");
  } else {
    Serial.println("°C Value error");
    Serial.println("Error: " + firebaseData.errorReason());
  }
  if (Firebase.setFloat(firebaseData, "sensor_data/temperature°F", tempFahrenheit)) {
    Serial.println("°F Value");
  } else {
    Serial.println("°F Value error");
    Serial.println("Error: " + firebaseData.errorReason());
  }

  delay(100);
}

void TdsSensor() {
  static unsigned long analogSampleTimepoint = millis();
  if (millis() - analogSampleTimepoint > 40U) { //every 40 milliseconds,read the analog value from the ADC
    analogSampleTimepoint = millis();
    analogBuffer[analogBufferIndex] = analogRead(TDS_INPUT);    //read the analog value and store into the buffer
    analogBufferIndex++;
    if (analogBufferIndex == SCOUNT) {
      analogBufferIndex = 0;
    }
  }

  static unsigned long printTimepoint = millis();
  if (millis() - printTimepoint > 800U) {
    printTimepoint = millis();
    for (copyIndex = 0; copyIndex < SCOUNT; copyIndex++) {
      analogBufferTemp[copyIndex] = analogBuffer[copyIndex];

      // read the analog value more stable by the median filtering algorithm, and convert to voltage value
      averageVoltage = getMedianNum(analogBufferTemp, SCOUNT) * (float)VREF / 1024.0;

      //temperature compensation formula: fFinalResult(25^C) = fFinalResult(current)/(1.0+0.02*(fTP-25.0));
      float compensationCoefficient = 1.0 + 0.02 * (temperature - 25.0);
      //temperature compensation
      float compensationVoltage = averageVoltage / compensationCoefficient;

      //convert voltage value to tds value
      tdsValue = (133.42 * compensationVoltage * compensationVoltage * compensationVoltage - 255.86 * compensationVoltage * compensationVoltage + 857.39 * compensationVoltage) * 0.5;

      Serial.print("TDS Value:");
      Serial.print(tdsValue, 0);
      Serial.println("ppm");

      if (Firebase.setFloat(firebaseData, "sensor_data/TDS", tdsValue, 0)) {
        Serial.println("TDS Value");
      } else {
        Serial.println("TDS Value error");
        Serial.println("Error: " + firebaseData.errorReason());
      }

    }
  }
}
