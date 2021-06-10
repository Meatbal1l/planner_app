import 'package:flutter/material.dart';
import 'package:planner_app/done_screen.dart';
import 'package:planner_app/main_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FinishedPlans(),
  ];
  final planned = <PlannerEvent>[];
  final done = <PlannerEvent>[];

  void _onItemTap(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}

class PlannerEvent {
  bool done = false;
  String actionDescription = '\0';

  PlannerEvent(String actionDescription) {
    this.done = false;
    this.actionDescription = actionDescription;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlannerEvent &&
          this.runtimeType == other.runtimeType &&
          this.actionDescription == other.actionDescription);

  @override
  int get hashCode => actionDescription.hashCode;
}
