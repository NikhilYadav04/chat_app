import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/Bloc/HomeBloc/bloc/home_bloc_bloc.dart';
import 'package:chat_app/data/drawer_data.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:flutter/material.dart';

String group_name = "";

List<IconData> iconData = [Icons.group, Icons.account_circle, Icons.logout];

class Functions {
  final Bloc homebloc;
  BuildContext context;
  Functions({required this.homebloc, required this.context});

  Group() {
    homebloc.add(Group_clicked_Event());
  }

  Profile() {
    homebloc.add(Profile_clicked_Event());
  }

  Logout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Logout",
              style: TextStyle(fontFamily: "Manrope"),
            ),
            content: Text(
              "Are you sure you want to logout?",
              style: TextStyle(fontFamily: "Manrope"),
            ),
            actions: [
              InkWell(
                onTap: () {
                  homebloc.add(Logout_clicked_Event(context: context));
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              )
            ],
          );
        });
  }
}

PreferredSizeWidget AppB(double width, double height, double textScaleFactor,
    GlobalKey<ScaffoldState> globalKey, Bloc home_bloc_bloc) {
  return AppBar(
    toolbarHeight: responsiveContainerSize(75, width, height),
    backgroundColor: Colors.black,
    automaticallyImplyLeading: false,
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Groups",
      style: TextStyle(
          color: Colors.white,
          fontSize: responsiveFontSize(34, width, height, textScaleFactor),
          fontFamily: "Manrope",
          fontWeight: FontWeight.bold),
    ),
    leading: InkWell(
      onTap: () {
        globalKey.currentState?.openDrawer();
      },
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: responsiveContainerSize(34, width, height),
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
            right: 10 * horizontalPaddingFactor(width),
            top: 2 * verticalPaddingFactor(height)),
        child: InkWell(
          onTap: () {
            home_bloc_bloc.add(search_page_clicked_event());
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: responsiveContainerSize(34, width, height),
          ),
        ),
      ),
    ],
  );
}

Widget DrawerSc(
    double width,
    double height,
    double textScaleFactor,
    BuildContext context,
    Bloc homebloc,
    String? Home_Name,
    String? Home_Email) {
  final Functions functions = Functions(homebloc: homebloc, context: context);
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 40 * verticalPaddingFactor(height),
        horizontal: 5 * horizontalPaddingFactor(width)),
    color: Colors.white,
    width: responsiveContainerSize(340, width, height),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            size: responsiveContainerSize(180, width, height),
          ),
          SizedBox(
            height: responsiveContainerSize(10, width, height),
          ),
          Text(
            "$Home_Name",
            style: TextStyle(
                fontFamily: "Manrope",
                fontSize:
                    responsiveFontSize(40, width, height, textScaleFactor),
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: responsiveContainerSize(30, width, height),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Drawer_List.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      Drawer_List[index].label,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: responsiveFontSize(
                              24, width, height, textScaleFactor),
                          fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      iconData[index],
                      size: responsiveContainerSize(32, width, height),
                      color: index == 0 ? OrangeColor : Colors.grey.shade800,
                    ),
                    onTap: () {
                      index == 0
                          ? functions.Group()
                          : index == 1
                              ? functions.Profile()
                              : functions.Logout();
                    },
                  );
                }),
          )
        ],
      ),
    ),
  );
}

Widget DialogWidget(double width, double height, double textScaleFactor,
    BuildContext context, Bloc home_bloc_bloc) {
  return AlertDialog(
    title: Center(
      child: Text(
        "Create A Group",
        style: TextStyle(
            fontFamily: "Manrope",
            fontWeight: FontWeight.w500,
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      ),
    ),
    content: SingleChildScrollView(
      child: TextField(
        onChanged: (val) {
          group_name = val;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                responsiveBorderRadius(20, width, height)),
            borderSide: BorderSide(
                color: Colors.brown.shade800,
                width: responsiveBorderWidth(2, width, height)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                responsiveBorderRadius(20, width, height)),
            borderSide: BorderSide(
                color: OrangeColor,
                width: responsiveBorderWidth(2, width, height)),
          ),
        ),
      ),
    ),
    actions: [
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(OrangeColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)))),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
                fontSize:
                    responsiveFontSize(20, width, height, textScaleFactor),
                color: Colors.white),
          )),
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(OrangeColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)))),
          onPressed: () {
            home_bloc_bloc.add(group_create_clicked_event(context: context));
            Navigator.of(context).pop();
            final snackbar = SnackBar(
              duration: Duration(seconds: 4),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Success!!',
                message: 'Group Created Successfully!',
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          child: Text(
            "Create",
            style: TextStyle(
                fontSize:
                    responsiveFontSize(20, width, height, textScaleFactor),
                color: Colors.white),
          )),
    ],
  );
}
