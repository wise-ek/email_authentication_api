import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import '../firebase_auth_service.dart';
import '../homeScreen.dart';
import '../loginScreen.dart';
import '../movies.dart';

class MyProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController searchController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final apiKey = 'b944d6eba2d3f434fdb9d98457345ae8';
  final apiUrl = 'https://api.themoviedb.org/3/search/movie';
  final imageUrlPrefix = 'https://image.tmdb.org/t/p/w780';

  List<Movie> movieList = [];
  String? query;
  int currentPage = 0;
  callApi(String movieName, int currentPageCount) async {
    query = movieName;
    currentPage = currentPageCount;

    print(currentPage.toString() + "ksdbhj");

    final response = await http.get(
        Uri.parse('$apiUrl?api_key=$apiKey&query=$query&page=$currentPage'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      movieList.clear();

      for (var result in data['results']) {
        String title = result['title'];
        String imageUrl = '$imageUrlPrefix${result['poster_path']}';
        print(imageUrl + "sdokfkjfs");
        movieList.add(Movie(title: title, imageUrl: imageUrl));

        notifyListeners();

        print(movieList.length.toString() + "list lenghth");
      }
    } else {
      print("faaaaaaaaails");
    }
  }

  void loadPage(String movieName, int pageCount) {
    if (pageCount > 0) {
      callApi(movieName, pageCount);
    }
  }

  void clearControllers() {
    searchController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  final FirebaseAuthService auth = FirebaseAuthService();
  bool isSigningUp = false;

  void signUp(BuildContext context) async {
    isSigningUp = true;
    notifyListeners();

    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signUpWithEmailAndPassword(email, password);

    isSigningUp = false;
    notifyListeners();

    if (user != null) {
      print("User is successfully created");
      clearControllers();
      const snackBar = SnackBar(
          backgroundColor: Colors.deepPurple,
          duration: Duration(milliseconds: 3000),
          content: Text(
            "User is successfully created",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
      // Navigator.pushNamed(context, "/home");
    } else {
      print("Some error happend");
    }
  }

  bool isSigning = false;

  void signIn(BuildContext context) async {
    isSigning = true;
    notifyListeners();

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    isSigning = false;
    notifyListeners();

    if (user != null) {
      print("User is successfully signed in");
      const snackBar = SnackBar(
          backgroundColor: Colors.deepPurple,
          duration: Duration(milliseconds: 3000),
          content: Text(
            "User is successfully signed in",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      const snackBar = SnackBar(
          backgroundColor: Colors.deepPurple,
          duration: Duration(milliseconds: 3000),
          content: Text(
            "Some error occured",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(color: Colors.white),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("Some error occured");
    }
  }

  signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await firebaseAuth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        print("success...");
      }
    } catch (e) {
      print("faill...");
      // showToast(message: "some error occured $e");
    }
  }
}
