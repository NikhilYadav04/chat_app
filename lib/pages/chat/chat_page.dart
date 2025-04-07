// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:chat_app/Bloc/Chat/bloc/chatpage_bloc.dart';
import 'package:chat_app/pages/chat/group_info.dart';
import 'package:chat_app/pages/home/home_page.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/widgets/chat/chat_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class ChatPage extends StatefulWidget {
  String groupID;
  String groupName;
  String userName;
  ChatPage({
    Key? key,
    required this.groupID,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatBloc = ChatpageBloc();
  bool chat_loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatBloc.add(Chat_Initial_Event(groupID: widget.groupID));
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
      bloc: chatBloc,
      listenWhen: (previous, current) => current is ChatpageActionState,
      buildWhen: (previous, current) => current is! ChatpageActionState,
      listener: (context, state) {
        if (state is info_clicked_State) {
          print("STate reached");
          Navigator.push(
              context,
              PageTransition(
                  child: GroupInfo(
                    groupID: widget.groupID,
                    groupName: widget.groupName,
                    userName: widget.userName,
                  ),
                  type: PageTransitionType.rightToLeft));
        } else if (state is exit_success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Group Left Successfully")));
          Navigator.push(context,
              PageTransition(child: HomePage(), type: PageTransitionType.fade));
        } else if (state is chat_message_delete_await_state) {
          setState(() {
            chat_loading = true;
          });
        } else if (state is chat_message_delete_state) {
          setState(() {
            chat_loading = false;
          });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case Chat_Initial_State:
            final success = state as Chat_Initial_State;
            return SafeArea(
              child: Scaffold(
                appBar: AppBChatPage(context, width, height, textScaleFactor,
                    widget.groupName, chatBloc,widget.groupID),
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: chat_loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: OrangeColor,
                                  ),
                                )
                              : Messages(width, height, textScaleFactor,
                                  success.chats, widget.userName),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Typing(width, height, textScaleFactor,
                              widget.userName, widget.groupID, chatBloc),
                        ),
                      ],
                    ),
                    // Messages(width,height,textScaleFactor,success.chats,widget.userName),
                    // Container(
                    //  alignment: Alignment.bottomCenter,
                    //   child: Typing(width, height, textScaleFactor,widget.userName,widget.groupID,chatBloc),
                    // ),
                  ],
                ),
              ),
            );
          case loading_state:
            return CircularProgressIndicator(
              color: OrangeColor,
            );
          case temp_chats:
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
