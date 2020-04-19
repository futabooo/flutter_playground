import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> key = GlobalKey();
final GlobalKey<NavigatorState> key2 = GlobalKey();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Nested Navigator',
      navigatorKey: key,
      onGenerateRoute: _generateRoute,
    );
  }

  Route _generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    WidgetBuilder builder;
    switch (routeSettings.name) {
      case '/':
        builder = (BuildContext _) => HomePage();
        break;
      case '/second':
        builder = (BuildContext _) => SecondPage();
        break;
      case '/third':
        builder = (BuildContext _) => ThirdPage();
        break;
      default:
        throw Exception('Invalid route: ${routeSettings.name}');
    }
    return MaterialPageRoute(builder: builder, settings: routeSettings);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        key.currentState.pushNamed('/second');
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text('Home Page'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "second/home",
      key: key2,
      onGenerateRoute: (RouteSettings routeSettings) {
        WidgetBuilder builder;
        switch (routeSettings.name) {
          case "second/home":
            builder = (BuildContext context) => SecondHomePage();
            break;
          case "second/second":
            builder = (BuildContext context) => SecondSecondPage();
            break;
        }
        return MaterialPageRoute(builder: builder, settings: routeSettings);
      },
    );
  }
}

class SecondHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        key2.currentState.pushNamed('second/second');
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text('Second Home Page'),
      ),
    );
  }
}

class SecondSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        key.currentState.pushNamed('/third');
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text('Second Second Page'),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('Third Page'),
    );
  }
}
