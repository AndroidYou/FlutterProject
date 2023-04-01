import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget{
  const HomeRoute({Key? key}) : super(key: key);

   @override
  _HomeRouteState createState() {
    // TODO: implement createElement
    return  _HomeRouteState();
  }
}
class _HomeRouteState extends State<HomeRoute>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:const Text("Main"),centerTitle: true,
      bottom: TabBar(tabs: [],

      ),),

    );
  }

}