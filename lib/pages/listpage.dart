import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantme/constants/colors.dart';
import 'package:plantme/pages/DetailPage.dart';
import 'package:plantme/widget/myplant_home.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("typePlant").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffce8dd),
      ),
      child: Column(
        children: [
          //CategoryTitle('The world of Plants', ''),
          //    Row(

          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'The world of Plants',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold, fontSize: 15, color: kFont),
          //     ),
          //   ],
          // ),
          // Positioned(
          //   top: 50,
          //   left: 60,
          //   child: Text(
          //     'The world of Plants',
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold, fontSize: 20, color: kFont),
          //   ),
          // ),
           Myplant_home('The world of Plants'),
          Container(
            height: 250,
            width: 350,
            child: FutureBuilder(
                future: getPosts(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading.."),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(30),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        final pic = snapshot.data[index].data["imgUrl"];
                        return Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                height: 230,
                                width: 220,
                                decoration: BoxDecoration(
                                    color: kPrimaryLight,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: pic != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              child: FadeInImage.assetNetwork(
                                                height: 230,
                                                width: 220,
                                                placeholder: 'assets/Asset_1.png',
                                                image: pic,
                                                fit: BoxFit.cover,
                                              ))
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffffb179),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              width: 1000,
                                              height: 1000,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.black,
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5),
                                                Row(children: [
                                                  Text(
                                                      '${snapshot.data[index].data["name"]}'),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    width: 5,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        color: kFontLight,
                                                        shape: BoxShape.circle),
                                                  )
                                                ])
                                              ])),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 30, //30
                              right: 20, //20
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: korange,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => DetailPage(course)));
                                  navigateToDetail(snapshot.data[index]);
                                },
                                child: Text('Start'),
                              ),
                            ),
                            // ListTile(
                            //   title: Text(snapshot.data[index].data["start"]),
                            //   //onTap:()=> navigateToDetail(snapshot.data[index]) ,
                            // ),
                          ],
                        );
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
