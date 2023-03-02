part of 'camera_bloc.dart';

abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraReady extends CameraState {}

class CameraFailure extends CameraState {
  final String? error;

  CameraFailure({this.error = "CameraFailure"});
}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  final XFile file;

  CameraCaptureSuccess(this.file);
}

class CameraCaptureFailure extends CameraReady {
  final String error;

  CameraCaptureFailure({this.error = "CameraFailure"});
}
