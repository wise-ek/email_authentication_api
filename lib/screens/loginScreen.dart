import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/providers/myprovider.dart';
import 'package:learn/screens/signupScreen.dart';
import 'package:learn/widgets/forrmContainer_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
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
                    onTap: () {
                      value.signIn(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: value.isSigning ? CircularProgressIndicator(
                          color: Colors.white,) : Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 10,),
              Consumer<MyProvider>(
                builder: (context,value,child) {
                  return GestureDetector(
                    onTap: () {
                      value. signInWithGoogle(context);

                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(width: 5,),
                            Text(
                              "Sign in with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                  Text("Don't have an account?"),
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
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
