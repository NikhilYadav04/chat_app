import 'package:chat_app/Bloc/Search/bloc/search_bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/search_page_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final searchbloc = SearchBloc();
  bool isLoading = false;
  bool hasSearched = false;
  late QuerySnapshot? groupshot = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchbloc.add(Search_Initial_Event());
    getName();
  }

  @override
  void dispose() {
    searchbloc.close();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: searchbloc,
      buildWhen: (previous, current) => current is! SearchActionState,
      listenWhen: (previous, current) => current is SearchActionState,
      listener: (context, state) {
        if (state is Loading_State || state is Join_Group_State) {
          setState(() {
            isLoading = true;
          });
        } else if (state is Loading_Finished_State) {
          setState(() {
            isLoading = false;
            hasSearched = true;
          });
        } else if (state is Search_Completed_State) {
          final success = state as Search_Completed_State;
          groupshot = success.groupsnapshot;
        } else if (state is Check_Group_State) {
          setState(() {
            print("Check_Group_State");
            widget_loading = true;
          });
        } else if (state is Check_Group_State_Complete) {
          print("Check_Group_State_Complete");
          setState(() {
            print("Check_Group_State");
            widget_loading = false;
          });
        }
        else if(state is Join_Group_Complete_State){
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case Search_Initial_State:
            return SafeArea(
              child: Scaffold(
                appBar: AppBSearch(context, width, height, textScaleFactor),
                body: Column(
                  children: [
                    SearchField(width, height, textScaleFactor,
                        searchController, searchbloc, context),
                    SizedBox(
                      height: responsiveBorderWidth(15, width, height),
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.yellow.shade800,
                          ))
                        : GroupList(groupshot, width, height, textScaleFactor,
                            hasSearched, searchbloc)
                  ],
                ),
              ),
            );
          // Add other cases for different states if needed
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
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
