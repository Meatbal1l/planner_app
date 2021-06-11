import 'package:flutter/material.dart';
import 'package:planner_app/new_plan.dart';
import 'package:planner_app/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabsScreen(),
      routes: <String, WidgetBuilder> {
        TabsScreen.routeName: (context) => TabsScreen(),
      },
      onGenerateRoute: (RouteSettings settings){
        var pathObj;
        String routeString = settings.name.toString();
        switch(routeString){
          case NewPlanScreen.routeName:
            pathObj = NewPlanScreen(
              arguments: settings.arguments as Map,
            );
            break;
        }
        return MaterialPageRoute(builder: (context) => pathObj);
      },
    );
  }
}
