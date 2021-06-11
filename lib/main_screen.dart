import 'package:flutter/material.dart';
import 'package:planner_app/new_plan.dart';
import 'package:planner_app/tabs.dart';

class HomeScreen extends StatefulWidget {
  final Map? arguments;

  const HomeScreen({Key? key, @required this.arguments}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map _arguments = {};
  List<PlannerEvent> _localArgumentsList = [];
  List<PlannerEvent> _planned = [];
  List<PlannerEvent> _done = [];

  void _onAddTap() {
    Navigator.of(context)
        .pushNamed(NewPlanScreen.routeName, arguments: _arguments)
        .then((value) {
      setState(() {});
    });
  }

  @override
  void initState() {
    _arguments = widget.arguments as Map;
    _done = _arguments['done'];
    _planned = _arguments['planned'];

    _localArgumentsList =
        List.from(Map.from(_arguments)['planned'] as List<PlannerEvent>);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planned Events"),
      ),
      body: _getPlannedEventsList(),
    );
  }

  Widget _getPlannedEventsList() {
    final allListTiles = _getPlannedTiles();

    return ListView.builder(
      itemCount: 1 + allListTiles.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final int index = i ~/ 2;

        return allListTiles[index];
      },
    );
  }

  List<Widget> _getPlannedTiles() {
    final tiles = _localArgumentsList.map((PlannerEvent event) {
      return ListTile(
        title: Transform.translate(
          child: Text(
            event.actionDescription,
            style: _arguments['biggerFont'],
          ),
          offset: Offset(-40, -0),
        ),
        leading: Transform.translate(
          child: IconButton(
            icon: _done.contains(event)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: _done.contains(event) ? Colors.red : null,
            onPressed: () {
              setState(() {
                if (_done.contains(event)) {
                  _done.remove(event);
                  _planned.add(event);
                } else {
                  _done.add(event);
                  _planned.remove(event);
                }
              });
            },
          ),
          offset: Offset(-20, -0),
        ),
      );
    });
    return tiles.isNotEmpty
        ? ListTile.divideTiles(tiles: tiles, context: context).toList()
        : <Widget>[];
  }
}
