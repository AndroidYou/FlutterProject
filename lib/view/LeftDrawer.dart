import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                  accountName: Text("data"), accountEmail: Text("data"))
            ],
          )),
    );
  }
}
