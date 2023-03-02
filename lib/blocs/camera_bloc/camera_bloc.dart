import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'camera_event.dart';

part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? _controller;

  CameraController getController() => _controller!;

  bool isInitialized() => _controller!.value.isInitialized;

  bool _photoIsFinished = true;

  bool getPhotoIsFinished() => _photoIsFinished;

  set setPhotoIsFinished(bool photoIsFinished) {
    _photoIsFinished = photoIsFinished;
  }

  CameraBloc() : super(CameraInitial()) {
    on<CameraInitialized>((event, emit) async {
      try {
        List<CameraDescription> cameras = await availableCameras();
        _controller = CameraController(
          cameras[0],
          ResolutionPreset.max,
        );
        await _controller!.initialize();
        emit(CameraReady());
      } on CameraException catch (error) {
        _controller?.dispose();
        emit(CameraFailure(error: error.description));
      } catch (error) {
        emit(CameraFailure(error: error.toString()));
      }
    });
    on<CameraCaptured>((event, emit) async {
      if (state is CameraReady) {
        _photoIsFinished = false;
        emit(CameraCaptureInProgress());
        try {
          XFile resultPicture = await _controller!.takePicture();
          emit(CameraCaptureSuccess(resultPicture));
          _photoIsFinished = true;
        } on CameraException catch (error) {
          emit(CameraCaptureFailure(error: error.description!));
          _photoIsFinished = true;
        }
      }
    });
    on<CameraStopped>((event, emit) async {
      _controller!.dispose();
      emit(CameraInitial());
    });
  }
}
