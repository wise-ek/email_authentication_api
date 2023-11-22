import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/providers/myprovider.dart';
import 'package:provider/provider.dart';

class AddMember extends StatelessWidget {
  const AddMember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const SizedBox(
            height: 20,
          ),
          Consumer<MyProvider>(
            builder: (context,value,child) {
              return InkWell(
                onTap: (){
                  // value.callApi();

                },
                child: Container(
                  height: 50,
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Text("Add")),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
