import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/profile_page_widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileScreenPage extends StatefulWidget {
  String? name;
  String? email;
  ProfileScreenPage({super.key, required this.name, required this.email});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
        child: Scaffold(
      appBar: ProfileAppBar(width, height, textScaleFactor,context),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: 140 * verticalPaddingFactor(height),
            horizontal: 50 * horizontalPaddingFactor(width)),
        child: Center(
          child: Column(
            children: [
              IconProfile(width, height),
              SizedBox(height: responsiveContainerSize(20, width, height),),
              Text1(height, width, textScaleFactor, widget.name),
              Text2(height, width, textScaleFactor, widget.email)
            ],
          ),
        ),
      ),
    ));
  }
}
