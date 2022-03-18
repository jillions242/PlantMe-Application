import 'package:flutter/material.dart';
import 'signUp_screen.dart';
import 'login_screen.dart';

class Welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE8DD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        height: MediaQuery.of(context).size.height * 0.61,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Image(
                          image: AssetImage('assets/Asset_1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        alignment: Alignment(0.0, 0.0),
                        //height: MediaQuery.of(context).size.height * 0.7,
                        //width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          'Your Personal \nPlant Care Helper',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xFF5c7873),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 60, left: 10, right: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF5c7873),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF0D4037),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith(
                                  (states) => Color(0xFFC4B2A1))),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Color(0xFFFCE8DD),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          //color: Color(0xFF5c7873),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith(
                            (states) => Color(0xFFC4B2A1),
                          )),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Color(0xFFFCE8DD),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
