import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/providers/myprovider.dart';
import 'package:learn/widgets/forrmContainer_widget.dart';
import 'package:provider/provider.dart';

import 'loginScreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("SignUp"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<MyProvider>(
                builder: (context,value,child) {
                  return FormContainerWidget(
                    controller: value.usernameController,
                    hintText: "Username",
                    isPasswordField: false,
                  );
                }
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<MyProvider>(
                builder: (context,value,child) {
                  return FormContainerWidget(
                    controller: value.emailController,
                    hintText: "Email",
                    isPasswordField: false,
                  );
                }
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<MyProvider>(
                builder: (context,value,child) {
                  return FormContainerWidget(
                    controller: value.passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                  );
                }
              ),
              SizedBox(
                height: 30,
              ),
              Consumer<MyProvider>(
                builder: (context,value,child) {
                  return GestureDetector(
                    onTap:  (){
                      value.signUp(context);

                    },
                    child: Consumer<MyProvider>(
                      builder: (context,value,child) {
                        return Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child:value. isSigningUp ? CircularProgressIndicator(color: Colors.white,):Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              )),
                        );
                      }
                    ),
                  );
                }
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  Consumer<MyProvider>(
                    builder: (context,value,child) {
                      return GestureDetector(
                          onTap: () {

                            value.clearControllers();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                    (route) => false);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ));
                    }
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
