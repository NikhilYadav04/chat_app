// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_app/Bloc/Chat/bloc/chatpage_bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/pages/home/home_page.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/group_info_widgets.dart';
import 'package:chat_app/widgets/chat/search_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class GroupInfo extends StatefulWidget {
  String groupID;
  String groupName;
  String userName;

  GroupInfo({
    Key? key,
    required this.groupID,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  final chatBloc = ChatpageBloc();
  String admin = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBloc.add(Group_info_initial_Event(groupID: widget.groupID));
    getName();
  }

  @override
  void dispose() {
    chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return BlocConsumer<ChatpageBloc, ChatpageState>(
      listenWhen: (previous, current) => current is ChatpageActionState,
      buildWhen: (previous, current) => current is! ChatpageActionState,
      listener: (context, state) {
        if (state is exit_success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Group Left Successfully")));
          Navigator.push(context,
              PageTransition(child: HomePage(), type: PageTransitionType.fade));
        }
      },
      bloc: chatBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case Group_info_initial_State:
            final success = state as Group_info_initial_State;
            admin = success.admin.substring(success.admin.indexOf("_") + 1);
            return SafeArea(
              child: Scaffold(
                appBar: AppBGroupInfo(context, width, height, textScaleFactor,
                    chatBloc, widget.groupName, widget.groupID),
                body: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10 * horizontalPaddingFactor(width),
                            vertical: 15 * verticalPaddingFactor(height)),
                        child: AdminBox(width, height, textScaleFactor, admin,
                            widget.groupName),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 * horizontalPaddingFactor(width),
                          ),
                          child: MemberBox(width, height, textScaleFactor,
                              success.members, context, admin)),
                    ],
                  ),
                ),
              ),
            );
          case loading_state:
            return Center(
              child: CircularProgressIndicator(
                color: OrangeColor,
              ),
            );
          case temp:
            return Center(
              child: Text("Empty"),
            );
          default:
            return Center(
              child: CircularProgressIndicator(
                color: OrangeColor,
              ),
            );
        }
      },
    );
  }
}

Future getName() async {
  search_name = await HelperFunctions.getUserName();
}
