import 'package:chat_app/model/drawer_model.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:flutter/material.dart';

final List<Drawer_Model> Drawer_List = [
  Drawer_Model(
      icon: Icon(
        Icons.group,
        color: OrangeColor,size: 30,
      ),
      label: " Groups",
      index: 1,
      ),
  Drawer_Model(
      icon: Icon(Icons.account_circle,size: 30,),
      label: " Profile",
      index: 2,
      ),
  Drawer_Model(
      icon: Icon(Icons.logout,size: 30,), label: " Logout", index: 3, ),
];


