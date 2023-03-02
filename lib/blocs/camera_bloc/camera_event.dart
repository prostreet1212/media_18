part of 'camera_bloc.dart';

abstract class CameraEvent {}

class CameraInitialized extends CameraEvent {}

class CameraStopped extends CameraEvent {}

class CameraCaptured extends CameraEvent {}
