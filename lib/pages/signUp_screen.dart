
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:plantme/constants/colors.dart';
import 'package:plantme/controllers/authentication.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:plantme/pages/login_screen.dart';
import 'package:plantme/pages/homepage.dart';
import 'package:plantme/pages/welcome_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  bool isPasswordVisible = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                  HomePage(uid: value.uid), //TasksPage(uid: value.uid)
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D4037),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D4037),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Welcomepage()));
          },
          icon: Image(
            width: 24,
            color: Color(0xFFFCE8DD),
            image: Svg('assets/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Color(0xFFFCE8DD),
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                        ),
                        Text(
                          'Create new account to get started.',
                          style: TextStyle(
                              color: Color(0xFFFCE8DD),
                              fontWeight: FontWeight.w400,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  style: bodytext1.copyWith(
                                      color: Color(0xFFFCE8DD)),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(20),
                                    hintText: 'E-mail',
                                    hintStyle: bodytext1,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFCE8DD),
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                  ),
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    email = val;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: TextFormField(
                                    style: bodytext1.copyWith(
                                        color: Color(0xFFFCE8DD)),
                                    obscureText: isPasswordVisible,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isPasswordVisible =
                                                  !isPasswordVisible;
                                            });
                                          },
                                          icon: Icon(
                                            isPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xFFFCE8DD),
                                          ),
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(20),
                                      hintText: 'Password',
                                      hintStyle: bodytext1,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFCE8DD),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "This Field Is Required."),
                                      MinLengthValidator(6,
                                          errorText:
                                              "Minimum 6 Characters Required.")
                                    ]),
                                    onChanged: (val) {
                                      password = val;
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?  ",
                                      style: bodytext1,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: bodytext1.copyWith(
                                            color: Color(0xFFFCE8DD),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                // RaisedButton(
                                //   onPressed: handleSignup,
                                //   color: Colors.green,
                                //   textColor: Colors.white,
                                //   child: Text(
                                //     "Sign Up",
                                //   ),
                                // ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE55D45),
                                    //color: Color(0xFF5c7873),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: TextButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.resolveWith(
                                      (states) => Color(0xFFF79651),
                                    )),
                                    onPressed: handleSignup,
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Color(0xFFFCE8DD),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
