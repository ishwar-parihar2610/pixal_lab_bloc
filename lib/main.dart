import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_bloc.dart';
import 'package:pixal_lab_bloc/features/view/Display_Images.dart';
import 'package:pixal_lab_bloc/util/Utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PixalBloc(),
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DisplayImages(),
      ),
    );
  }
}
