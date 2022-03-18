

import 'package:flutter/material.dart';
import 'package:plantme/constants/colors.dart';

class DetailCustom extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
     color: Color( 0xfffce8dd),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: kFont),
              ),
            ],
          ),
          //SizedBox(height: 20),
         
        ],
      ),
    );
  }
}
