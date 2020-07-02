import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';
import 'package:theja/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: activeTab == AppTab.home
              ? null
              : AppBar(
                  title: Text("TheJA"),
                ),
          body: activeTab == AppTab.home ? Home() : List(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Icon(activeTab == AppTab.home ? Icons.search : Icons.add),
            ),
            elevation: 4.0,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            child: Bottom(),
          ),
        );
      },
    );
  }
}
