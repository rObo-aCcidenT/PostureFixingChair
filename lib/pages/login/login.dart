import 'package:splashh/pages/forgot_password.dart';
import 'package:splashh/services/authentication_service.dart';
import 'package:splashh/pages/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splashh/utils/color.dart';
import 'package:splashh/components/navigation_bar.dart' as MyNavigationBar;

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override 
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController nameController= new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
   try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MyNavigationBar.NavigationBarCustom(username: nameController.text),
    ),
  );
} 
on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.primaryColor,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.primaryColor,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(
                width: MediaQuery.of(context).size.width* .6,

        child: Column(
          children: [
            Container(
                width: 300,
                child: Image.asset(
                  "assets/images/loyellow.png",
                  fit: BoxFit.contain,
                  height:150.0,
                )),
            SizedBox(
              height: 30.0,
            ),

            
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 48,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Username';
                          }
                          return null;
                        },
                        controller: nameController,
                        style: TextStyle(
                          fontSize: 12.0, // Set font size here
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            
                            hintText: "Username",
                            
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: 300,
                      height: 48,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        style: TextStyle(
                          fontSize: 12.0, // Set font size here
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 12.0, fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: 300,
                      height: 48,
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFedf0f8),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 12.0, fontWeight: FontWeight.w400)),
                   obscureText: true,   ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mailcontroller.text;
                            password=passwordcontroller.text;
                          });
                          userLogin(); // Call the userLogin function here
                        }
                      },
                      child: Container(
                          width: 300,
                          height: 48,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Log In",
                            style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w900),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
              },
              child: Text("Forgot Password?",
                  style: TextStyle(
                      color: Color(0xFF8c8e98),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "or LogIn with",
              style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Image.asset(
                    "assets/images/google.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                // GestureDetector(
                //   onTap: (){
                //     AuthMethods().signInWithApple();
                //   },
                //   child: Image.asset(
                //     "assets/images/apple1.png",
                //     height: 50,
                //     width: 50,
                //     fit: BoxFit.cover,
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                    style: TextStyle(
                        color: Color(0xFF8c8e98),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )    
    );
  }
}

