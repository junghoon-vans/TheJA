import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/tab/tab.dart';
import 'package:theja/route.dart';
import 'package:theja/screens/screens.dart';

void main() => runApp(Theja());

class Theja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TheJA",
      initialRoute: '/',
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
            ],
            child: HomeScreen(),
          );
        },
      },
    );
  }
}
