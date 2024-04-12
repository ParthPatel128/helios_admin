import 'package:flutter/material.dart';

import 'add_meals_page.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff023034),
        title: const Text("Meals"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  AddMealsPage(),
                    ));
              },
              icon: const Icon(
                Icons.add_circle_outline,
                size: 30,
              ))
        ],
      ),
    );
  }
}
