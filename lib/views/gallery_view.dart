



import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:media_18/screens/media_screen.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);




  /*needRotation(String path) async {
    Map<String, IfdTag> data =
    await readExifFromBytes(await new File(path).readAsBytes());
    return data['EXIF ExifImageWidth'].values[0] >
        data['EXIF ExifImageLength'].values[0];
  }*/


  @override
  Widget build(BuildContext context) {
    return imageList.isEmpty?
        Center(child: Text('Галерея пуста'),):
    ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (context,index)   {


         /* RotatedBox(
                quarterTurns: 3,
            child: Text('aaa'),);*/
              return Container(
            width: MediaQuery.of(context).size.width,
            //height: 100,
            child: Image.file( File(imageList[index].path)),
          );
        });

  }
}
