import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  // final Course course;
  // CustomAppBar(this.course);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 25,
      child: Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)),
        child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            iconSize: 20,
            onPressed: () => Navigator.of(context).pop()),
      ),
    );
  }
}
