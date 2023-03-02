import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_18/blocs/gallery_bloc/gallery_bloc.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GalleryBloc galleryBloc = context.read<GalleryBloc>();
    return BlocBuilder<GalleryBloc, GalleryState>(builder: (context, state) {
      if (state is GalleryReadyState) {
        List<XFile> imageList = state.imageList;
        return imageList.isEmpty
            ? const Center(
                child: Text('Галерея пуста'),
              )
            : ListView.separated(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<String?>(
                      future: galleryBloc.needRotation(imageList[index].path),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: SizedBox(),
                            );
                          case ConnectionState.done:
                            //проверка на вертикальность
                            if (snapshot.data!.contains('90')) {
                              return Image.file(
                                File(imageList[index].path),
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                              );
                            } else {
                              return Image.file(File(imageList[index].path));
                            }
                          default:
                            return Container(
                                width: 50, height: 50, color: Colors.yellow);
                        }
                      });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 1,
                    color: Colors.white,
                  );
                },
              );
      } else {
        return Container();
      }
    });
  }
}
