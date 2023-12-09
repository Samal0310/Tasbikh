import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/top_panel_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_panel.dart';
import 'saves_db.dart';
import 'top_panel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    backgroundColor: Colors.lightBlueAccent,
    body: SafeArea(
    bottom: false,
    child: Padding(
    padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
    child: Column(
    children: [
    TopPanel(),
    CounterPanel(),
    SavesDB(),
            ],
          ),
        ),
      ),
    );
  }
}






