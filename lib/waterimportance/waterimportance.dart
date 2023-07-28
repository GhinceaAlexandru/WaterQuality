import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'quiz_screen.dart';

void main() {
  runApp(WaterImportanceApp());
}

class WaterImportanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Importance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: WaterImportancePage(),
    );
  }
}

class WaterImportancePage extends StatefulWidget {
  @override
  _WaterImportancePageState createState() => _WaterImportancePageState();
}

class _WaterImportancePageState extends State<WaterImportancePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.0),
                  Center(
                    child: Text(
                      'Water and Its Benefits',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 250.0,
                      child: TyperAnimatedTextKit(
                        isRepeatingAnimation: true,
                        speed: Duration(milliseconds: 100),
                        text: ['Stay Hydrated', 'Drink Water'],
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.info,
                        title: 'Why is Water Important?',
                        description:
                            'Water is essential for maintaining good health. It plays a crucial role in various bodily functions, including hydration, nutrient absorption, temperature regulation, and detoxification. Staying hydrated helps keep your body functioning optimally and promotes overall well-being.',
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.local_drink,
                        title: 'Hydration',
                        description:
                            'Water helps to keep your body hydrated, which is important for overall bodily functions.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.local_bar,
                        title: 'Nutrient Absorption',
                        description:
                            'Water aids in the digestion and absorption of nutrients from the food we consume.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.thermostat,
                        title: 'Temperature Regulation',
                        description:
                            'Water helps regulate body temperature, especially during physical activities or exposure to high temperatures.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.healing,
                        title: 'Detoxification',
                        description:
                            'Water flushes out toxins from the body through urine and sweat.',
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        'Optimal Ranges:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.phonelink_setup,
                        title: 'pH Range',
                        description:
                            'The optimal pH range for drinking water is between 6.5 and 8.5. Maintaining the pH balance is important for water taste and its compatibility with the body.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.waves,
                        title: 'TDS (Total Dissolved Solids) Range',
                        description:
                            'The optimal TDS range for drinking water is generally considered to be less than 500 parts per million (ppm). TDS refers to the concentration of dissolved solids, including minerals and salts, in water.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.waves,
                        title: 'Turbidity Range',
                        description:
                            'The optimal turbidity range for drinking water is typically less than 5 NTU (Nephelometric Turbidity Units). Turbidity refers to the cloudiness or haziness of water caused by suspended particles.',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: WaterInfoCard(
                        icon: Icons.thermostat_outlined,
                        title: 'Temperature Range',
                        description:
                            'The optimal temperature for drinking water is generally between 50°F (10°C) and 60°F (15.5°C). This temperature range is considered refreshing and thirst-quenching.',
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        'Cleanest Rivers in Romania:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: CleanestRiverCard(
                        riverName: 'Jiu River',
                        description:
                            'The Jiu River is known for its exceptional water quality and stunning natural beauty. It flows through the Jiu Valley, a region renowned for its picturesque landscapes and crystal-clear waters. The river is a popular destination for fishing, boating, and other water activities.',
                        imageAsset: 'assets/jiu_river.jpg',
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: CleanestRiverCard(
                        riverName: 'Lotru River',
                        description:
                            'The Lotru River is one of the cleanest rivers in Romania, known for its pristine water quality and unspoiled natural surroundings. It flows through the Lotru Mountains, offering breathtaking views and a tranquil environment. The river is a popular spot for nature enthusiasts and outdoor adventurers.',
                        imageAsset: 'assets/lotru_river.jpg',
                      ),
                    ),
                  ),
                  SizedBox(height: 64),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await Future.delayed(Duration.zero);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: Colors.blue,
                      ),
                      child: Text(
                        'Take the Quiz',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const WaterInfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CleanestRiverCard extends StatelessWidget {
  final String riverName;
  final String description;
  final String imageAsset;

  const CleanestRiverCard({
    required this.riverName,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            child: Image.asset(
              imageAsset,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  riverName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
