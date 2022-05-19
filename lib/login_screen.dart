import 'package:flutter/material.dart';
import 'package:food_delivery/colors.dart';
import 'package:food_delivery/constant.dart';
import 'package:food_delivery/new_screen.dart';
import 'colors.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'new_class.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  void sigIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password).catchError((onError){}).then((authUser){
      if(authUser.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    String image = foodImage;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainImage(height: height, width: width, image: image),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Container(
                    child: const Text(
                      ' $loginValue ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                        border: const Border(
                            left: BorderSide(color: primaryColor, width: 4))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return "Not Valid Email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: primaryColor,
                        ),
                        labelText: "EMAIL ADDRESS",
                        labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please Enter Password";
                      } else if (password.length < 8 || password.length > 15) {
                        return "Password Length is incorrect";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.lock_open,
                          color: primaryColor,
                        ),
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: const Text(forgetPassword),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width - 400,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: FlatButton(
                        color: primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            sigIn(context);
                          }
                        },
                        child: const Text(
                          'Login to account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have a account?"),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewScreen()));
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

