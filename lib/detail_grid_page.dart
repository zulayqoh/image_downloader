import 'package:flutter/material.dart';
import 'package:image_downloader/image_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  _ImageGridState createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  String savePath = '';
  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }
  Container imageList(List<Picture> pictures) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(pictures.length, (index) {
          return Center(
            child: Column(
              children: <Widget>[Text(pictures[index].name)],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
        ),
        children: [

          Image.file(
          File(savePath)),
          Image.network('https://picsum.photos/250?image=1'),
          Image.network('https://picsum.photos/250?image=2'),
          Image.network('https://picsum.photos/250?image=3'),
          Image.network('https://picsum.photos/250?image=4'),
        ],
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Image.file(File(imagePath));
  }
}
