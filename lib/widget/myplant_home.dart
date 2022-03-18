import 'package:flutter/material.dart';
import 'package:plantme/constants/colors.dart';

class Myplant_home extends StatefulWidget {
  final String leftText;
  //final String rightText;
  Myplant_home(this.leftText);

  @override
  State<Myplant_home> createState() => _Myplant_homeState();
}

class _Myplant_homeState extends State<Myplant_home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.leftText,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 23, color: kFont),
          ),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     textStyle: const TextStyle(fontSize: 16, color: kFontLight),
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => AllPlants(plants: plants),
          //         ),
          //       );
          //     });
          //   },
          //   child: const Text('View all'),
          // ),
          // Positioned(
          //   bottom: 30, //30
          //   right: 20, //20
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         primary: korange,
          //         elevation: 0,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10))),
          //     onPressed: () {
          //       // Navigator.of(context).push(MaterialPageRoute(
          //       //     builder: (context) => DetailPage(course)));
          //       //navigateToDetail(snapshot.data[index]);
          //     },
          //     child: Text('Start'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
