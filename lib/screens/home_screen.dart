import 'package:flutter/material.dart';
import 'package:theja/views/views.dart';
import 'package:theja/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collections"),
      ),
      body: CollectionView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingButton(),
    );
  }
}
