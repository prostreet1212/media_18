import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_18/blocs/gallery_bloc/gallery_bloc.dart';
import '../../blocs/camera_bloc/camera_bloc.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraBloc? cameraBloc;

  XFile? lastImage;

  @override
  void initState() {
    super.initState();
    cameraBloc = context.read<CameraBloc>();
    cameraBloc!.add(CameraInitialized());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!cameraBloc!.isInitialized()) return;

    if (state == AppLifecycleState.inactive) {
      cameraBloc!.add(CameraStopped());
    } else if (state == AppLifecycleState.resumed) {
      cameraBloc!.add(CameraInitialized());
    }
  }

  @override
  void dispose() {
    cameraBloc!.add(CameraStopped());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state is CameraCaptureFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is CameraCaptureSuccess) {
          context.read<GalleryBloc>().add(GalleryAddImageEvent(state.file));
          print('BBB ${(state).file.path}');
        }
      },
      builder: (context, state) {
        if (state is CameraReady ||
            state is CameraCaptureInProgress ||
            state is CameraCaptureSuccess) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: CameraPreview(cameraBloc!.getController()),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    child: const Icon(Icons.camera),
                    onPressed: () async {
                      cameraBloc!.setPhotoIsFinished = false;
                      //photoIsFinished = false;
                      cameraBloc!.add(CameraCaptured());
                    },
                  ),
                ),
              )
            ],
          );
        } else if (state is CameraInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CameraFailure) {
          return Center(
            child: Text(state.error!),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
