import 'package:chat_app/Bloc/HomeBloc/bloc/home_bloc_bloc.dart';
import 'package:chat_app/pages/chat/profile_screen_page.dart';
import 'package:chat_app/pages/chat/search_page.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/home/home_page_body.dart';
import 'package:chat_app/widgets/home/home_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final HomeBlocBloc homeBlocBloc = HomeBlocBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBlocBloc.add(HomeBlock_Initial_Event());
  }

  @override
  void dispose() {
    homeBlocBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: BlocConsumer<HomeBlocBloc, HomeBlocState>(
        bloc: homeBlocBloc,
        buildWhen: (previous, current) => current is! HomeBlocActionState,
        listenWhen: (previous, current) => current is HomeBlocActionState,
        listener: (context, state) {
          if (state is Group_clicked_State) {
            globalKey.currentState!.closeDrawer();
          } else if (state is Profile_clicked_Stat) {
            final success = state as Profile_clicked_Stat;
            Navigator.push(
                context,
                PageTransition(
                    child: ProfileScreenPage(
                      name: success.Profil_Name,
                      email: success.Profile_Email,
                    ),
                    type: PageTransitionType.fade));
          } else if (state is Logout_clicked_State) {
            authService.signOut(context);
          } else if (state is Add_Button_Clicked_State) {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogWidget(
                      width, height, textScaleFactor, context, homeBlocBloc);
                });
          } else if (state is search_page_clicked_state) {
            Navigator.push(
                context,
                PageTransition(
                    child: SearchPage(), type: PageTransitionType.rightToLeft));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeBlock_Initial_State:
              final success = state as HomeBlock_Initial_State;
              return Scaffold(
                resizeToAvoidBottomInset: true,
                key: globalKey,
                drawer: DrawerSc(width, height, textScaleFactor, context,
                    homeBlocBloc, success.Home_Name, success.Home_Email),
                appBar: AppB(
                    width, height, textScaleFactor, globalKey, homeBlocBloc),
                // print(success.Home_Name);
                // print(success.Home_Email);
                body: Stack(children: [
                  groupList(success.snapshots, width, height, textScaleFactor),
                ]),

                floatingActionButton: FloatingActionButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    homeBlocBloc.add(Add_Button_Clicked_Event());
                  },
                  elevation: 0,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    size: responsiveContainerSize(40, width, height),
                    color: Colors.white,
                  ),
                ),
              );
            case Loading_State:
              return CircularProgressIndicator(
                color: OrangeColor,
              );

            default:
              return Center(
                child: CircularProgressIndicator(
                  color: OrangeColor,
                ),
              );
          }
        },
      ),
    );
  }
}
