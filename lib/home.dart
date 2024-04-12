import 'package:flutter/material.dart';

import 'categories/meals_page.dart';
import 'categories/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff023034),
        title: const Text("Show Categories",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          categoriesItems(title: "Order",onTap: (){}),
          categoriesItems(title: "Product",onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage(),));
          }),
          categoriesItems(title: "Meals",onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MealsPage(),));
          }),
        ],
      ),
    );
  }
}
Widget categoriesItems(
{ required String title,Function? onTap}
    ){
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 1),)
          ]),
      child: Center(
        child: Text(title,
            style: const TextStyle(
              // color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
    ),
  );
}
