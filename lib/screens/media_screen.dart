
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:media_18/views/camera_view.dart';
import 'package:media_18/views/gallery_view.dart';

List<XFile> imageList=[];

class MediaScreen extends StatefulWidget {
   MediaScreen({Key? key}) : super(key: key);


  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  
  int _selectedIndex = 0;

  List<Widget> _widgetOptions =[
    CameraView(),
    GalleryView(),
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> _appBarTitleList=['Camera preview','images gallery'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitleList[_selectedIndex]),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
          label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'Gallery'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _onItemTapped,
        //onTap: _onItemTapped,
      ),
    );
  }
}
