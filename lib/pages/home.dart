import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';

    Color bgColor = data['isDayTime'] ? Colors.blue : Color(0xFF303F9F);

    Color textColor = data['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                label: const Text(
                  'Edit Location',
                  style: TextStyle(
                    color: Color.fromRGBO(224, 224, 224, 1),
                  ),
                ),
                icon: const Icon(
                  Icons.edit_location,
                  color: Color.fromRGBO(224, 224, 224, 1),
                ),
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'isDayTime': result['isDayTime'],
                    };
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      color: textColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66,
                  letterSpacing: 2,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
