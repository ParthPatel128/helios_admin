import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Order"),
      centerTitle: true,
      ),
    );
  }
}
