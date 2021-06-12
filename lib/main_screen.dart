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
      setState(() {
        _localArgumentsList = List.from(_planned);
      });
    });
  }

  @override
  void initState() {
    _arguments = widget.arguments as Map;
    _done = _arguments['done'];
    _planned = _arguments['planned'];
    _localArgumentsList = List.from(_planned);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planned Events"),
        actions: [
          IconButton(
            onPressed: _onAddTap,
            icon: Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: _getPlannedEventsList(),
    );
  }

  Widget _getPlannedEventsList() {
    final allListTiles = _getPlannedTiles();

    return ListView.builder(
      itemCount: allListTiles.length,
      itemBuilder: (context, i) {
        // if (i.isOdd) return Divider();
        // final int index = i ~/ 2;
        final int index = i;

        return allListTiles[index];
      },
    );
  }

  List<Widget> _getPlannedTiles() {
    final tiles = _localArgumentsList.map((PlannerEvent event) {
      return ListTile(
        title: Transform.translate(
          child: TextFormField(
            initialValue: event.actionDescription,
            // keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: _arguments['biggerFont'],
            // minLines: 1,
            maxLines: null,
            onChanged: (text) {
              setState(() {
                event.actionDescription = text;
              });
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              setState(() {
                if (event.actionDescription == "") _planned.remove(event);
              });
            },
            onFieldSubmitted: (text) {
              FocusScope.of(context).unfocus();
              setState(() {
                if (text == "") _planned.remove(event);
              });
            },
          ),
          offset: Offset(-40, -0),
        ),
        leading: Transform.translate(
          child: IconButton(
            icon: _done.contains(event)
                ? Icon(Icons.check_box_outlined)
                : Icon(Icons.check_box_outline_blank_rounded),
            color: _done.contains(event) ? Colors.green : null,
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
