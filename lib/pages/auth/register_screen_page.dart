// ignore_for_file: unnecessary_type_check

import 'package:chat_app/Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/auth/register_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreenPage extends StatefulWidget {
  const RegisterScreenPage({super.key});

  @override
  State<RegisterScreenPage> createState() => _RegisterScreenPageState();
}

class _RegisterScreenPageState extends State<RegisterScreenPage> {
  final TextEditingController RegisterNamecontroller = TextEditingController();
  final TextEditingController RegisterEmailcontroller = TextEditingController();
  final TextEditingController RegisterPasswordcontroller =
      TextEditingController();
  final AuthBlocBloc authBlocBloc = AuthBlocBloc();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBlocBloc.add(RegisterInitializeEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authBlocBloc.close();
    RegisterEmailcontroller.dispose();
    RegisterNamecontroller.dispose();
    RegisterPasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        bloc: authBlocBloc,
        buildWhen: (previous, current) => current is !AuthBlockActionState,
        listenWhen: (previous, current) => current is AuthBlockActionState,
        listener: (context, state) {
          if (state is LoginPageNavigateState) {
            Navigator.push(
                context,
                PageTransition(
                    child: LoginPage(), type: PageTransitionType.leftToRight));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case RegisterInitializeState:
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 * horizontalPaddingFactor(width),
                        vertical: 95 * verticalPaddingFactor(height)),
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        children: [
                          HeaderTextRegister(height, width, textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(15, width, height),
                          ),
                          Text1Register(height, width, textScaleFactor),
                          ImageRegister(height, width, textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(18, width, height),
                          ),
                          NameField(RegisterNamecontroller, height, width,
                              textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(5, width, height),
                          ),
                          EmailField(RegisterEmailcontroller, height, width,
                              textScaleFactor),
                          SizedBox(
                            height: responsiveContainerSize(5, width, height),
                          ),
                          PasswordField(
                            height: height,
                            width: width,
                            textScaleFactor: textScaleFactor,
                            passController: RegisterPasswordcontroller,
                          ),
                          SizedBox(
                            height: responsiveContainerSize(8, width, height),
                          ),
                          InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  authBlocBloc.add(RegisterButtonClickedEvent(
                                      context: context));
                                }
                              },
                              child: RegisterButton(
                                  context, height, width, textScaleFactor)),
                          SizedBox(
                            height: responsiveContainerSize(20, width, height),
                          ),
                          Text2Register(
                              context, height, width, textScaleFactor),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            case RegisterButtonClickedState:
              return Center(
                child: CircularProgressIndicator(
                  color: OrangeColor,
                ),
              );
            default:
              print(" executed");
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
