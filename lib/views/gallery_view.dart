import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:media_18/screens/media_screen.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  Future<String?> needRotation(String path) async {
    Map<String, IfdTag> data =
        await readExifFromBytes(await new File(path).readAsBytes());
    String orientation = data['Image Orientation']!.printable;
    print('aaa $orientation');
    return orientation;
  }

  @override
  Widget build(BuildContext context) {
    return imageList.isEmpty
        ? Center(
            child: Text('Галерея пуста'),
          )
        : ListView.separated(
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return FutureBuilder<String?>(
                  future: needRotation(imageList[index].path),
                  builder: (context, snaphot) {
                    switch (snaphot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(),
                        );
                      case ConnectionState.done:
                        //проверка на вертикальность
                         if(snaphot.data!.contains('90')){
                           return Image.file( File(imageList[index].path),height: MediaQuery.of(context).size.height/2.5,);
                         }else{
                           return Image.file( File(imageList[index].path));
                         }
                      default:
                        return Container(
                            width: 50, height: 50, color: Colors.yellow);
                    }
                  });
              /* RotatedBox(
                quarterTurns: 3,
            child: Text('aaa'),);*/
              /*  return Container(
            width: MediaQuery.of(context).size.width,
            //height: 100,
            child: Image.file( File(imageList[index].path)),
          );*/
            }, separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 1,color: Colors.white,);
    },);
  }
}
