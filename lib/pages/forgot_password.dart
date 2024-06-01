import 'package:splashh/pages/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashh/utils/color.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 20.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 20.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width* .6,
          child: Column(
            children: [
              SizedBox(
                height: 70.0,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Password Recovery",
                  style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              // Text(
              //   "Enter your mail",
              //   style: TextStyle(
              //       color: AppColors.accentColor,
              //       fontSize: 20.0,
              //       fontWeight: FontWeight.w900),
              // ),
              Expanded(
                  child: Form(
                      key: _formkey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.accentColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                controller: mailcontroller,
                                style: TextStyle(color: AppColors.accentColor),
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 18.0, color: AppColors.accentColor, fontWeight: FontWeight.w400),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: AppColors.accentColor,
                                      size: 30.0,
                                    ),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email=mailcontroller.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: Container(
                                width: 300,
                                height: 48,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.accentColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Send Email",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontSize: 16.0, color: AppColors.accentColor, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}