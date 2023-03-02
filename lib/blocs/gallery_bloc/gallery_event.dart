part of 'gallery_bloc.dart';

abstract class GalleryEvent {}

class GalleryAddImageEvent extends GalleryEvent {
  XFile file;

  GalleryAddImageEvent(this.file);
}
