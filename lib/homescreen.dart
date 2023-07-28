import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SensorDataScreen.dart';
import 'package:waterreminder/gmaps/rivers.dart';
import 'app.dart';
import 'profilepage.dart';
import 'package:waterreminder/waterimportance/waterimportance.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Shader nameGradient = LinearGradient(
      colors: <Color>[Colors.purple, Colors.blue],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "WQ",
                          style: GoogleFonts.alata(
                            textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = nameGradient,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Carousel Slider
                    CarouselSlider(
                      items: [
                        Image.asset('assets/img1.jpg', fit: BoxFit.cover),
                        Image.asset('assets/img2.jpg', fit: BoxFit.cover),
                        Image.asset('assets/img3.jpg', fit: BoxFit.cover),
                      ],
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOut,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Top Panels
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: PanelItem(
                            icon: Icons.check_circle,
                            label: 'Check Water Quality',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SensorDataScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: PanelItem(
                            icon: Icons.eco,
                            label: 'Cleanest Rivers in Romania',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RiversHome(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: PanelItem(
                            icon: Icons.notifications,
                            label: 'Water Reminder',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => App(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: PanelItem(
                            icon: Icons.info,
                            label: 'Water Importance',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaterImportanceApp(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Water Information Panel
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(.4),
                            BlendMode.darken,
                          ),
                          image: AssetImage('assets/sea.jpg'),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "We love quality water, do you?",
                              style: GoogleFonts.alata(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "We aim for the coexistence of the earth's environment and humankind.",
                              style: GoogleFonts.alata(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (int index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}

class PanelItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;

  const PanelItem({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    routes: {
      '/profile': (context) => ProfilePage(),
    },
  ));
}
