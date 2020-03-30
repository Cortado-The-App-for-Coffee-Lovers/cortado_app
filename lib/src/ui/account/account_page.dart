import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:flutter/material.dart';

class AccountPage extends DrawerPage {
  AccountPage(Drawer drawer) : super(drawer);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(),
    );
  }
}
