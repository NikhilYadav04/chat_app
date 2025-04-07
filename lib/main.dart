// ignore_for_file: unnecessary_type_check

import 'dart:async';

import 'package:chat_app/Bloc/Main/bloc/main_bloc.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/home/home_page.dart';
import 'package:chat_app/pages/onbaord/splash_screen_page.dart';
import 'package:chat_app/pages/onbaord/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//1:855616288198:android:2cdca7148e065f4127eec7

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainBloc mainBloc = MainBloc();
  late bool _loggedIn;
  bool _showSplash = true;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    mainBloc.add(Check_User_Logged_In_Event(context: context));

    Timer(Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      debugShowCheckedModeBanner: false,
      home: _showSplash
          ? SplashScreenPage()
          : BlocConsumer<MainBloc, MainState>(
              bloc: mainBloc,
              buildWhen: (previous, current) => current is MainState,
              listenWhen: (previous, current) => current is! MainState,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case Check_User_Logged_In_State:
                    final Success_state = state as Check_User_Logged_In_State;
                    _loggedIn = Success_state.key_value!;
                    print(_loggedIn);
                    return _loggedIn ? HomePage() : StartPage();

                  case Loading_State:
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
    );
  }
}
