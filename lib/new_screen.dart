import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/home_screen.dart';
import 'new_class.dart';
import 'colors.dart';
import 'constant.dart';
class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _user;
  void login(BuildContext context) async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).catchError((onError){}).then((authUser){
      if(authUser.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    String image = createImage;
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      ' $createAccount ',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onSaved: (value) {
                      _user = value!;
                    },
                    validator: (user) {
                      if (user!.isEmpty) {
                        return "Please Enter Username";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(
                          Icons.emoji_people,
                          color: primaryColor,
                        ),
                        labelText: "USER NAME",
                        labelStyle: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    onSaved: (email) {
                      _email = email!;
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
                    onSaved: (password) {
                      _password = password!;
                      print(password);
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
                const SizedBox(height: 20),
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
                            login(context);
                          }
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Go Back",
                          style: TextStyle(color: primaryColor, fontSize: 20),
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
