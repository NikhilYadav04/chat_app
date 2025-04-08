// ignore_for_file: unnecessary_type_check

import 'package:chat_app/Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';
import 'package:chat_app/pages/home/home_page.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/auth/login_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKeyL = GlobalKey<FormState>();
  final AuthBlocBloc authBlocBloc = AuthBlocBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    authBlocBloc.add(LoginInitializeEvent());
  }

  @override
  void dispose() {
    super.dispose();
    authBlocBloc.close();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        bloc: authBlocBloc,
        buildWhen: (previous, current) => current is! AuthBlockActionState,
        listenWhen: (previous, current) => current is AuthBlockActionState,
        listener: (context, state) {
          if (state is HomePageNavigateState) {
            Navigator.push(
                context,
                PageTransition(
                    child: HomePage(), type: PageTransitionType.rightToLeft));
          }
          if (state is LoginStartState) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is LoginEndState) {
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginInitializeState:
              return Form(
                key: formKeyL,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 * horizontalPaddingFactor(width),
                        vertical: 95 * verticalPaddingFactor(height)),
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        children: [
                          HeaderText(height, width, textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(15, width, height),
                          ),
                          Text1(height, width, textScaleFactor),
                          LoginImage(height, width),
                          SizedBox(
                            height: responsiveContainerSize(18, width, height),
                          ),
                          EmailTextField(
                              emailController, height, width, textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(5, width, height),
                          ),
                          PasswordTextField(
                            height: height,
                            width: width,
                            textScaleFactor: textScaleFactor,
                            passController: passwordController,
                          ),
                          SizedBox(
                            height: responsiveContainerSize(8, width, height),
                          ),
                          isLoading
                              ? CircularProgressIndicator(
                                  color: OrangeColor,
                                )
                              : InkWell(
                                  onTap: () {
                                    if (formKeyL.currentState!.validate()) {
                                      authBlocBloc.add(LoginButtonClickedEvent(
                                          context: context));
                                    }
                                  },
                                  child: LoginButton(
                                      context, height, width, textScaleFactor)),
                          SizedBox(
                            height: responsiveContainerSize(15, width, height),
                          ),
                          Text2(context, height, width, textScaleFactor),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            default:
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.yellow.shade800,
              ));
          }
        },
      ),
    );
  }

  login() {
    if (formKeyL.currentState!.validate()) {}
  }
}
