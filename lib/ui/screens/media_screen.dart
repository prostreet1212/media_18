import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_18/blocs/camera_bloc/camera_bloc.dart';
import '../../blocs/bottom_navigation_bar_bloc/bottom_navigation_bar_bloc.dart';
import '../views/camera_view.dart';
import '../views/gallery_view.dart';

class MediaScreen extends StatelessWidget {
  MediaScreen({Key? key}) : super(key: key);

  final List<Widget> _bottomWidgets = [
    const CameraView(),
    const GalleryView(),
  ];
  final List<String> _appBarTitleList = ['Camera preview', 'images gallery'];

  @override
  Widget build(BuildContext context) {
    CameraBloc cameraBloc = context.read<CameraBloc>();
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        int selectedIndex;
        if (state is BottomNavigationBarCurrentState) {
          selectedIndex = state.currentIndex;
        } else {
          selectedIndex = (state as BottomNavigationBarInitial).currentIndex;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(_appBarTitleList[selectedIndex]),
            centerTitle: true,
          ),
          body: _bottomWidgets.elementAt(selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera), label: 'Camera'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo), label: 'Gallery'),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.lightBlue,
              onTap: (index) {
                if (cameraBloc.getPhotoIsFinished()) {
                  context
                      .read<BottomNavigationBarBloc>()
                      .add(BottomNavigationCurrentEvent(index));
                }
              }),
        );
      },
    );
  }
}
