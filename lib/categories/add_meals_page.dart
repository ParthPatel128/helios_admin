import 'package:flutter/material.dart';

class AddMealsPage extends StatefulWidget {
  const AddMealsPage({super.key});

  @override
  State<AddMealsPage> createState() => _AddMealsPageState();
}

class _AddMealsPageState extends State<AddMealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff023034),
        title: const Text("Add Meals"),
        centerTitle: true,
      ),
    );
  }
}
