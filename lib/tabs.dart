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
  final _planned = <PlannerEvent>[];
  final _done = <PlannerEvent>[];

  final _biggerFont = TextStyle(fontSize: 20.0);

  int _selectedIndex = 0;

  Map _arguments = {};
  List<Widget> _widgetOptions = <Widget>[];

  void _onTabsTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _arguments = {
      'planned': _planned,
      'done': _done,
      'biggerFont': _biggerFont,
    };
    _widgetOptions = <Widget>[
      HomeScreen(arguments: _arguments),
      FinishedPlans(arguments: _arguments),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'planned',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive_rounded),
            label: 'finished',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabsTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
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
