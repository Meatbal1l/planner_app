import 'package:flutter/material.dart';

class NewPlanScreen extends StatefulWidget {
  static const String routeName = '/new_plan';

  final Map? arguments;
  const NewPlanScreen({Key? key, @required this.arguments}) : super(key: key);

  @override
  _NewPlanScreenState createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  Map arguments = {};
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
