
import 'package:flutter/material.dart';
import 'package:splashh/pages/login/login.dart';
import 'package:splashh/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashh/utils/color.dart';
import 'package:splashh/components/bg.dart';
import 'package:splashh/components/navigation_bar.dart' as MyNavigationBar;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    // ignore: unnecessary_null_comparison
    if (password != null&& nameController.text!=""&& mailcontroller.text!="") {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
                    // Store the username after successful registration
        setState(() {
          name = nameController.text;
        });
            
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Successfully",
          style: TextStyle(fontSize: 20.0),
        )));
        // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BackgroundWrapper(
          backgroundImage: 'images/bg.png',
          child: Scaffold(
            body: MyNavigationBar.NavigationBarCustom(username: name,),
        ),
      ),
     ),);
  //  BackgroundWrapper(
  //       backgroundImage: 'images/bg.png',
  //       child: Scaffold(
  //         body: MyNavigationBar.NavigationBar(),
  //       ),
  //     ),
     
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final double formWidth = MediaQuery.of(context).size.width > 600 ? 400 : MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(child: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [

      Container(
        width: MediaQuery.of(context).size.width*0.6,
        child: Column(
          children: [
            Container(
                // width: MediaQuery.of(context).size.width,
                width: 300,
                child: Image.asset(
                  "assets/images/loyellow.png",
                  fit:BoxFit.contain,
                  height: 150.0,
                )
            ),
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
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        controller: nameController,
                        style: TextStyle(
                          fontSize: 12.0, // Set font size here
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
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
                            return 'Please Enter Email';
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                        
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 12.0,fontWeight: FontWeight.w400)),
             obscureText: true,  ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email=mailcontroller.text;
                            name= nameController.text;
                            password=passwordcontroller.text;
                          });
                        }
                        registration();
                      },
                      child: Container(
                          // width: MediaQuery.of(context).size.width *.5,
                          width: 300, 
                          height: 48,// Use dynamic width
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Sign Up",
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
              height: 20.0,
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
                  width: 20.0,
                ),
                // Image.asset(
                //   "assets/images/apple1.png",
                //   height: 50,
                //   width: 50,
                //   fit: BoxFit.cover,
                // )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
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
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text(
                    "LogIn",
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
      ),)
      ),
      
     
    );
  }
}