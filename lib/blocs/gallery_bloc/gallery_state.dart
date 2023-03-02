part of 'gallery_bloc.dart';

abstract class GalleryState {}

class GalleryReadyState extends GalleryState {
  List<XFile> imageList = [];

  GalleryReadyState({required this.imageList});
}
