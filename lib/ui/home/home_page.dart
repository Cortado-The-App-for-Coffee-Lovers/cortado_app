import 'package:cortado_app/values/values.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String _title = "Coffee Shops";
  TabController _tabController;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          bottom: TabBar(
              unselectedLabelColor: Colors.white,
              indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
              controller: _tabController,
              tabs: [
                Tab(
                  text: "Coffees Left: ",
                ),
                Tab(
                  text: "Reload Date: ",
                )
              ]),
        ),
        body: Center(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.brown,
          items: [
            BottomNavigationBarItem(
              title: Text("Coffee shops"),
              icon: Icon(Icons.local_drink),
            ),
            BottomNavigationBarItem(
              title: Text("Your Account"),
              icon: Icon(Icons.person),
            )
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _title = "Coffee Shops";
        _selectedIndex = index;
      });
    } else {
      setState(() {
        _title = "Account";
        _selectedIndex = index;
      });
    }
  }

  List<Widget> _homePageOptions = <Widget>[_coffeeShopList(), _account()];
}

_coffeeShopList() {
  return Container(
    child: ListView.builder(itemBuilder: (context, index) {}),
  );
}

_account() {}
