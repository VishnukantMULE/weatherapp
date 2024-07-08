import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/screens/test/api/singlepostapi.dart';
import 'package:weatherapp/screens/test/model/SinglePostModel.dart';

class Postview extends StatefulWidget {
  const Postview({super.key});

  @override
  State<Postview> createState() => _PostviewState();
}

class _PostviewState extends State<Postview> {

  bool isReady=false;


SinglePostModel postmodel=SinglePostModel();

  _getSinglePost()
  {

    isReady=true;
    ApiService().getSinglePost().then((val){
      setState(() {
        postmodel=val!;
        isReady=false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSinglePost();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post View"),
      ),
      body: isReady==true?
      Center(
        child: CircularProgressIndicator(),
      ):
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ffffffffffffffff"),
              Text(postmodel.userId.toString()),
              ElevatedButton(onPressed: (){
                ApiService().getSinglePost().then((val){
                  print(val);
                });
              }, child: Text("Refresh"))
            ],
          )
    );
  }
}
