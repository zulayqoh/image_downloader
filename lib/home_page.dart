import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'detail_grid_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var imageUrl = '';
  bool downloading = true ;
  String downloadingString = 'No Data';
  String savePath = '';
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
   // downloadFile();
  }


  // How to download file in flutter

  Future downloadFile() async {
    try {
      Dio dio = Dio();

      String fileName = textController.text.substring(textController.text.lastIndexOf('/') + 1);

      savePath = await getFilePath(fileName);

      await dio.download(textController.text, savePath, onReceiveProgress: (rec,total){

        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingString = 'downloadingImage: $rec';
        });
      });
      setState(() {
        downloading = false;
        downloadingString = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // final String imageURL =
  //     'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80';

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text(
          'IMAGE DOWNLOADER',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                 focusedBorder: OutlineInputBorder(
                   borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                 ),
                    // border:OutlineInputBorder(
                    //   borderSide: const BorderSide(color: Colors.green, width: 2.0),
                    //   //borderRadius: BorderRadius.circular(25.0),
                    // ),
                    hintText: 'Enter URL of image to load'),
              ),

           SizedBox(height: 10,),

              Center(
                child: downloading
                    ? Container(
                  height: 250,
                  width: 250,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          downloadingString,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
                    : Container(
                  height: 250,
                  width: 250,
                  child: Center(
                    child: Image.file(
                      File(savePath),
                      height: 200,
                    ),
                  ),
                ),
              ),
           SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      downloadFile();
                      setState(() {
                        textController.text;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, //button's fill color
                      onPrimary: Colors.amber,
                      side: BorderSide(color: Colors.white70, width: 5.0, style: BorderStyle.solid),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0),),),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Download',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),

                  ElevatedButton(
                    //onPressed: () {},
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ImageGrid(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //button's fill color
                      onPrimary: Colors.black,
                      side: BorderSide(color: Colors.black, width: 5.0, style: BorderStyle.solid),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0),),),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Gallery',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
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

