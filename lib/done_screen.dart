import 'package:flutter/material.dart';
import 'package:planner_app/tabs.dart';

class FinishedPlans extends StatefulWidget {
  final Map? arguments;

  const FinishedPlans({Key? key, @required this.arguments}) : super(key: key);

  @override
  _FinishedPlansState createState() => _FinishedPlansState();
}

class _FinishedPlansState extends State<FinishedPlans> {
  Map _arguments = {};
  List<PlannerEvent> _planned = [];
  List<PlannerEvent> _done = [];
  List<PlannerEvent> _localArgumentsList = [];

  @override
  void initState() {
    _arguments = widget.arguments as Map;
    _done = _arguments['done'];
    _planned = _arguments['planned'];
    _localArgumentsList = List.from(_done);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _localArgumentsList = List.from(_done);

    return Scaffold(
      appBar: AppBar(
        title: Text("Finished Events"),
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
                if (event.actionDescription == "") _done.remove(event);
              });
            },
            onFieldSubmitted: (text) {
              FocusScope.of(context).unfocus();
              setState(() {
                if (text == "") _done.remove(event);
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
