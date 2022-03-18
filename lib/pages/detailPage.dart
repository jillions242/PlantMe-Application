import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantme/constants/icons.dart';
import 'package:plantme/constants/colors.dart';
import 'package:plantme/constants/icons.dart';
import 'package:plantme/widget/Detail_custom.dart';
import 'package:plantme/widget/custom_app_bar.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(children: [
      Container(
        decoration: BoxDecoration(
          color: Color(0xfffce8dd),
        ),
        child: Stack(
            //color: Color(0xfffce8dd),
            // child: ListTile(
            //   title: Text(widget.post.data["start"]),
            //   subtitle: Text(
            //     widget.post.data["content"],
            //   ),
            // ),
            children: [
              Column(children: [
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    height: 300,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        //child: Image.asset(course.imageUrl, fit: BoxFit.fitHeight),
                        child: FadeInImage.assetNetwork(
                          //height: 230,
                          width: 600,
                          placeholder: 'assets/Asset_1.png',
                          image: widget.post.data["imgUrl"],
                          fit: BoxFit.cover,
                        ))),
                Container(
                  height: 20,
                ),
                //DetailCustom(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: korange,
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryDark2,
                          offset: Offset(1, 1),
                          blurRadius: 10,
                          spreadRadius: 0.005)
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  //padding: EdgeInsets.all(20),
                  height: 120,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: kFontLight2,
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 20, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Botanical name :  ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryLight),
                              ),
                              Text(
                                widget.post.data["Bname"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryLight),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //color: kFontLight,
                        margin:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Common name :  ',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimary),
                              ),
                              Text(
                                widget.post.data["name"],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimary),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 30, right: 10),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                              Icon(
                                IconData(sunIcon,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter'),
                                color: kFontLight2,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.post.data["light"],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 10),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                              Icon(
                                IconData(wateringIcon,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter'),
                                color: kFontLight2,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.post.data["water"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 30),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                              Icon(
                                IconData(temperatureIcon,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter'),
                                color: kFontLight2,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.post.data["temperature"],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 30, right: 10),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                              Icon(
                                IconData(toxicIcon ,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter'),
                                color: kFontLight2,
                                size: 40,
                              ),                  
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Toxic for pets : ${widget.post.data["toxicpet"]}',
                                 textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 10),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                                 Text(
                               'Bloom time',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.post.data["bloomtime"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryDark2,
                                offset: Offset(1, 1),
                                blurRadius: 10,
                                spreadRadius: 0.005)
                          ],
                        ),
                        //color: kFontLight,
                        margin: EdgeInsets.only(top: 20, left: 20, right: 30),
                        height: 100,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            children: [
                              Icon(
                                IconData(fertilizerIcon,
                                    fontFamily: 'FontAwesomeSolid',
                                    fontPackage: 'font_awesome_flutter'),
                                color: kFontLight2,
                                size: 40,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.post.data["Soil"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: kFontLight2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  //padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'Plant Overviews',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kFontLight2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 11),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    widget.post.data["poverview"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: kFontLight2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  //padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'Common Diseases ',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: kFontLight2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 11),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    widget.post.data["cdiseases"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: kFontLight2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color(0xfffce8dd),
                //   ),
                //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 15),
                //       SizedBox(height: 15),
                //       Text(
                //         widget.post.data["name"],
                //         style: TextStyle(
                //             wordSpacing: 2,
                //             fontSize: 16,
                //             color: Color(0xff315951)),
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color(0xfffce8dd),
                //   ),
                //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(height: 15),
                //       SizedBox(height: 15),
                //       Text(
                //         widget.post.data["name"],
                //         style: TextStyle(
                //             wordSpacing: 2,
                //             fontSize: 16,
                //             color: Color(0xff315951)),
                //       )
                //     ],
                //   ),
                // ),
              ]),
              // Positioned(
              //     top: MediaQuery.of(context).padding.top,
              //     left: 25,
              //     child: Container(
              //       height: 50,
              //       width: 50,
              //       padding: EdgeInsets.only(left: 5),
              //       decoration: BoxDecoration(
              //           color: Colors.black.withOpacity(0.3),
              //           borderRadius: BorderRadius.circular(15)),
              //       child: IconButton(
              //           icon: Icon(
              //             Icons.arrow_back_ios,
              //             color: Colors.white,
              //           ),
              //           iconSize: 20,
              //           onPressed: () => Navigator.of(context).pop()),
              //     )),
              CustomAppBar(),
            ]),
      )
    ])));
  }
}
