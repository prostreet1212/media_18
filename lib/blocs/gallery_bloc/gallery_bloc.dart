import 'dart:io';

import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gallery_state.dart';

part 'gallery_event.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  Future<String?> needRotation(String path) async {
    Map<String, IfdTag> data =
        await readExifFromBytes(await File(path).readAsBytes());
    String orientation = data['Image Orientation']!.printable;
    return orientation;
  }

  late String path;

  getNeedRotation() => needRotation(path);

  GalleryBloc() : super(GalleryReadyState(imageList: [])) {
    on<GalleryAddImageEvent>((event, emit) {
      if (state is GalleryReadyState) {
        (state as GalleryReadyState).imageList.add(event.file);
        emit(state);
      }
    });
  }
}
