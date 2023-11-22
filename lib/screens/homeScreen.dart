import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/providers/myprovider.dart';
import 'package:provider/provider.dart';

import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height;
    var width = queryData.size.width;
    return Scaffold(
      backgroundColor:Colors.black12 ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(

                alignment: Alignment.topRight,
                child: Consumer<MyProvider>(
                  builder: (context,value,child) {
                    return InkWell(
                      onTap: (){

                        FirebaseAuth.instance.signOut();
                        value.clearControllers();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                        child: Icon(Icons.power_settings_new_sharp,color: Colors.red,));
                  }
                ),
              ),
            ),

            SizedBox(
              height: 48,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0.50,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),

                ),

                child: Consumer<MyProvider>(
                    builder: (context, value, child) {
                      return TextField(
                        controller: value.searchController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Search Movies',
                          hintStyle: const TextStyle(
                              fontSize: 11, ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                value.callApi(value.searchController.text,1);

                              },
                              child: const Icon(
                                Icons.search,
                                color: Color(0xff414CA0),
                              )),
                        ),
                        onChanged: (item) {

                        },
                      );
                    }),
              ),
            ),
            Container(
              height: height*0.78,
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 14.0,right: 14,top: 18),
                child: Consumer<MyProvider>(
                    builder: (context,value,child) {
                      return  value.movieList.isNotEmpty?GridView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemCount: value.movieList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 130,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1.4,
                            crossAxisCount: 2,

                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return

                              Column(

                                  children: [
                                    Stack(
                                      alignment:Alignment.bottomRight,
                                      children: [
                                        InkWell(
                                          onTap:(){

                                          },
                                          child: !value.movieList[index].imageUrl.contains("null")? Container(
                                            height: height*0.131,
                                            // height: height*0.18,
                                            width: width*0.44,
                                            decoration:  BoxDecoration(
                                                borderRadius:BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        value.movieList[index].imageUrl
                                                    ),scale: 10,
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ):Container(
                                            height: height*0.131,
                                            // height: height*0.18,
                                            width: width*0.44,
                                            color: Colors.blue,

                                          ),
                                        ),


                                      ],
                                    ),

                                    Padding(
                                      padding:  EdgeInsets.only(left: 10.0,top: width*0.01),
                                      child: Text(value.movieList[index].title,style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold,fontFamily: "Poppins"),maxLines: 1,overflow: TextOverflow.ellipsis),
                                    ),




                                  ])
                                  ;
                          }):const Center(child: Text("Please search your favourite movie",style: TextStyle(color: Colors.white),));
                    }
                ),
              ),
            ),
            Consumer<MyProvider>(
              builder: (context,value,child) {
                return Visibility(
                  visible: value.currentPage>0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          value.loadPage(value.searchController.text, value.currentPage!- 1);
                        },
                        child: const Text('Previous'),
                      ),
                      const SizedBox(width: 16.0),
                      // Text('Page $_currentPage'),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          value.loadPage(value.searchController.text, value.currentPage!+1);
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                );
              }
            ),

          ],
        ),
      ),


    );
  }
}
