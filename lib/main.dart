import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/collection/collection.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/route.dart';
import 'package:theja/screens/screens.dart';

void main() => runApp(Theja());

class Theja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TheJA",
      initialRoute: '/',
      theme: ThemeData(
          highlightColor: Colors.transparent, splashColor: Colors.transparent),
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CollectionBloc>(
                create: (context) => CollectionBloc(),
              ),
            ],
            child: HomeScreen(),
          );
        },
        Routes.list: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<VehicleBloc>(
              create: (context) => VehicleBloc(),
            )
          ], child: ListScreen());
        }
      },
    );
  }
}
