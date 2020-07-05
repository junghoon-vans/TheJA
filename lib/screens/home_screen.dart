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
          body: Stack(
            children: <Widget>[
              activeTab == AppTab.home ? HomeView() : CollectionView(),
              ExpandView(),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingButton(),
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
