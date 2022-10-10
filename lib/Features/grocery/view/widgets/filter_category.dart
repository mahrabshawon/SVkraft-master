import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/model/category_model.dart';

import 'filter_subcategory.dart';

class FilterCatogory extends StatelessWidget {
  FilterCatogory({Key? key, required this.token}) : super(key: key);
  final String token;

  final GroceryCategoryController _groceryCategoryController =
      Get.put(GroceryCategoryController());

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery Product Categories'),
        ),
        body: FutureBuilder<List<GroceryCategoryData>?>(
            future: _groceryCategoryController.getGroceryCategory(token),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Product Found'));
                } else {
                  final data = snapshot.data;
                  return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 0, // blur radius
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              )
                            ],
                          ),
                          width: size.width,
                          height: 60,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FilterSubCatogory(
                                          token: token,
                                          id: data[index].id,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Image.network(
                                    data[index].image ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlwHeNYLE7WqyVjdQpNhbCKgpEHkfXcsmXqA&usqp=CAU',
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  data[index].name,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        );
                        // Card(
                        //   key: ValueKey(myProducts[index]),
                        //   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => FilterSubCatogory(
                        //                 category: myProducts[index].toString())),
                        //       );
                        //     },
                        //     child: Padding(
                        //         padding: const EdgeInsets.all(10),
                        //         child: Text(myProducts[index])),
                        //   ),
                        // );
                      });
                }
              }
            }));
  }
}
