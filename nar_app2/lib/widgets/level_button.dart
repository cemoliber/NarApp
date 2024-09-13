import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          child: Text('A1 Testine Başla'),
        ),
        ElevatedButton(
          onPressed: () {
            // 2. Butona basıldığında yapılacak işlemler
          },
          child: Text('A2 Testine Başla'),
        ),
        ElevatedButton(
          onPressed: () {
            // 3. Butona basıldığında yapılacak işlemler
          },
          child: Text('B1 Testine Başla'),
        ),
        ElevatedButton(
          onPressed: () {
            // 4. Butona basıldığında yapılacak işlemler
          },
          child: Text('B2 Testine Başla'),
        ),
        ElevatedButton(
          onPressed: () {
            // 5. Butona basıldığında yapılacak işlemler
          },
          child: Text('C1 Testine Başla'),
        ),
        ElevatedButton(
          onPressed: () {
            // 6. Butona basıldığında yapılacak işlemler
          },
          child: Text('C2 Testine Başla'),
        ),
      ],
    );
  }
}
