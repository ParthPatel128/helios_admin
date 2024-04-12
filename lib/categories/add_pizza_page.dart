import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../constant/assets_path.dart';

class AddPizzaPage extends StatefulWidget {
  final dynamic products;

  const AddPizzaPage({super.key, this.products});

  @override
  State<AddPizzaPage> createState() => _AddPizzaPageState();
}

class _AddPizzaPageState extends State<AddPizzaPage> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final _formKey = GlobalKey<FormState>();
  TextEditingController pizzaName = TextEditingController();
  TextEditingController regPrice = TextEditingController();
  TextEditingController medPrice = TextEditingController();
  TextEditingController larPrice = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  bool isLoaderVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.products != null) {
      pizzaName.text = widget.products['PizzaName'] ?? '';
      regPrice.text = widget.products['RegularPrice'] ?? '';
      medPrice.text = widget.products['MediumPrice'] ?? '';
      larPrice.text = widget.products['LargePrice'] ?? '';
      ingredients.text = widget.products['Ingredients'] ?? '';
    } else {
      pizzaName.clear();
      regPrice.clear();
      medPrice.clear();
      larPrice.clear();
      ingredients.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff023034),
        title: const Text("Add Pizza",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
Navigator.pop(context);
          },icon: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              children: [Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: widget.products != null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () async {
                            image = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {});
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              image != null
                                  ? Image.file(
                                File(
                                  image!.path,
                                ),
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.40,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.18,
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                widget.products['PizzaImage'],
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.40,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.18,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                padding: const EdgeInsets.all(7),
                                margin: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(Icons.photo,
                                    color: Colors.black, size: 25),
                              )
                            ],
                          ),
                        ))
                        : image == null
                        ? InkWell(
                      onTap: () async {
                        image = await picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {});
                      },
                      child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.asset(
                              addPizza,
                              color: Colors.grey,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width *
                                  0.40,
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height *
                                  0.18,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xff023034),
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              child: const Icon(Icons.photo,
                                  color: Colors.white, size: 25),
                            )
                          ]),
                    )
                        : InkWell(
                      onTap: () async {
                        image = await picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {});
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(
                                  image!.path,
                                ),
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.40,
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.18,
                                fit: BoxFit.cover,
                              )),
                          Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(20)),
                            child: const Icon(Icons.photo,
                                color: Colors.black, size: 25),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: pizzaName,
                      decoration: InputDecoration(
                          hintText: "Pizza Name",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black54),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2),
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Pizza name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: pizzaSize(
                            title: "Regular", controller: regPrice, validator:
                            (value) {
                          if (value!.isEmpty) {
                            return "Enter Price";
                          }
                          return null;
                        }),
                      ),
                      Expanded(
                        child:
                        pizzaSize(title: "Medium", controller: medPrice,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Price";
                              }
                              return null;
                            }),
                      ),
                      Expanded(
                          child: pizzaSize(title: "Large", controller: larPrice,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Price";
                                }
                                return null;
                              })),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: ingredients,
                      decoration: InputDecoration(
                          hintText: "Add Ingredients",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black54),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black87, width: 2),
                              borderRadius: BorderRadius.circular(15))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Ingredients";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
              ],
            ),
            isLoaderVisible
                ? Center(
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                color: Colors.black12,
                child: Lottie.asset("assets/json/pizzaLoader.json"),
              ),
            )
                : const SizedBox.shrink()
          ],
        ),
      ),
      bottomNavigationBar: InkWell
        (
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoaderVisible = true;
            });
            if (widget.products == null) {
              if (image == null) {
                isLoaderVisible = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("select image")));
                return;
              }
              final storageRef = FirebaseStorage.instance.ref();
              String imageName = "${DateTime.now().toString()}.jpg";
              final mountainsRef = storageRef.child(imageName);
              await mountainsRef.putFile(File(image!.path));
              String imageUrl = await mountainsRef.getDownloadURL();

              FirebaseFirestore.instance.collection("Product").add({
                "PizzaName": pizzaName.text,
                "Ingredients": ingredients.text,
                "RegularPrice": regPrice.text,
                "MediumPrice": medPrice.text,
                "LargePrice": larPrice.text,
                "PizzaImage": imageUrl,
              }).then((value) {
                Navigator.pop(context);
              });
            } else {
              String imageUrl = "";
              if (image != null) {
                final storageRef = FirebaseStorage.instance.ref();
                String imageName = "${DateTime.now().toString()}.jpg";
                final mountainsRef = storageRef.child(imageName);
                await mountainsRef.putFile(File(image!.path));
                imageUrl = await mountainsRef.getDownloadURL();
              }

              FirebaseFirestore.instance
                  .collection("Product")
                  .doc(widget.products['id'])
                  .update({
                "PizzaName": pizzaName.text,
                "Ingredients": ingredients.text,
                "RegularPrice": regPrice.text,
                "MediumPrice": medPrice.text,
                "LargePrice": larPrice.text,
                "PizzaImage":
                imageUrl == "" ? widget.products['PizzaImage'] : imageUrl,
              }).then((value) => Navigator.pop(context));
            }
          }
        },
        child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: Color(0xff023034),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
            child: Center(
              child: widget.products == null
                  ? const Text(
                "ADD",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
                  : const Text(
                "UPDATE",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
      ),
    );
  }
}

Widget pizzaSize(
    {required String title, required TextEditingController controller, required String? Function(String?)? validator}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    child: TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,      decoration: InputDecoration(
          labelText: title,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black87, width: 2),
              borderRadius: BorderRadius.circular(15))),
      // style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      validator: validator,
    ),
  );
}
