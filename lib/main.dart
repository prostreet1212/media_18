import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_18/blocs/camera_bloc/camera_bloc.dart';
import 'package:media_18/blocs/gallery_bloc/gallery_bloc.dart';
import 'package:media_18/ui/screens/media_screen.dart';

import 'blocs/bottom_navigation_bar_bloc/bottom_navigation_bar_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBarBloc>(
          create: (context) => BottomNavigationBarBloc(),
        ),
        BlocProvider<CameraBloc>(
          create: (context) => CameraBloc(),
        ),
        BlocProvider<GalleryBloc>(
          create: (context) => GalleryBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MediaScreen(),
      ),
    );
  }
}
