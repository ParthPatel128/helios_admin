import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helios_admin/constant/assets_path.dart';
import 'package:readmore/readmore.dart';

import 'add_pizza_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> pizzaList = [];

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          backgroundColor: const Color(0xff023034),
          title: const Text("Product",style: TextStyle(
            color: Colors.white
          ),),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
Navigator.pop(context);
            },icon: const Icon(Icons.arrow_back,color: Colors.white,),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  const AddPizzaPage(),
                      )).then((value) {
                    getProduct();
                  });
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 30,color: Colors.white,
                ))
          ],
        ),
        body: ListView.builder(
          itemCount: pizzaList.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 2, blurRadius: 2)
                  ]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            pizzaList[index]["PizzaImage"] ?? '',
                            width: MediaQuery.of(context).size.width*0.37,
                            height: MediaQuery.of(context).size.height*0.17,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pizzaList[index]["PizzaName"] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 2,
                            ),
                            ReadMoreText(
                              pizzaList[index]["Ingredients"] ?? '',
                              trimLines: 2,
                              colorClickableText:
                              Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText:
                              'Read more',
                              trimExpandedText: ' Read less',
                              moreStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.bold),
                              lessStyle: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Regular - ${pizzaList[index]["RegularPrice"] ?? ''}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Image.asset(
                                  ruppes,
                                  height: 15,
                                  width: 15,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Medium - ${pizzaList[index]["MediumPrice"] ?? ''}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Image.asset(
                                  ruppes,
                                  height: 15,
                                  width: 15,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Large - ${pizzaList[index]["LargePrice"] ?? ''}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Image.asset(
                                  ruppes,
                                  height: 15,
                                  width: 15,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddPizzaPage(products:pizzaList[index]),
                                        )).then((value){
                                          getProduct();
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text("EDIT",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection("Product")
                                        .doc(pizzaList[index]["id"])
                                        .delete();
                                    getProduct();
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text("DELETE",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  Future<void> getProduct() async {
    pizzaList.clear();
    QuerySnapshot<Map<String, dynamic>> list =
        await FirebaseFirestore.instance.collection("Product").get();
    for (int i = 0; i < list.docs.length; i++) {
      var map = list.docs[i].data();
      map['id'] = list.docs[i].id;
      pizzaList.add(map);
    }
    setState(() {});
  }
}
