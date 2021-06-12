import 'package:flutter/material.dart';
import 'package:planner_app/tabs.dart';

class NewPlanScreen extends StatefulWidget {
  static const String routeName = '/new_plan';

  final Map? arguments;
  const NewPlanScreen({Key? key, @required this.arguments}) : super(key: key);

  @override
  _NewPlanScreenState createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  Map _arguments = {};
  List<PlannerEvent> _planned = [];
  List<PlannerEvent> _done = [];

  @override
  void initState() {
    _arguments = widget.arguments as Map;
    _planned = _arguments['planned'];
    _done = _arguments['done'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Plan"),
      ),
      body: Transform.translate(
        offset: Offset(2, 1),
        child: TextField(
          autofocus: true,
          // maxLines: null,
          onSubmitted: (text) {
            setState(() {
              final newEvent = PlannerEvent(text);
              if (text != "" &&
                  !_planned.contains(newEvent) &&
                  !_done.contains(newEvent)) {
                _planned.add(newEvent);
                Navigator.of(context).pop();
              }
            });
          },
        ),
      ),
    );
  }
}
