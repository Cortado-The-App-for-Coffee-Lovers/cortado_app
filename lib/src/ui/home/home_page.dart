import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

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
  CoffeeShopsBloc _coffeeShopsBloc;
  Position _currentUserLocation;
  Map<CoffeeShop, Future<Position>> _userDistanceMap;

  final _homePageOptions = <Widget>[];

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _coffeeShopsBloc = BlocProvider.of(context);
    _getCurrentLocation();
    _userDistanceMap = Map.fromIterable(_coffeeShopsBloc.coffeeShops,
        key: (coffeeShop) => coffeeShop);
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeShopsBloc.close();
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
        body: Center(
            child: (_selectedIndex == 0) ? _coffeeShopList() : _account()),
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

  _coffeeShopList() {
    return Container(
      child: ListView.builder(
          itemCount: _coffeeShopsBloc.coffeeShops.length,
          itemBuilder: (context, index) {
            return CoffeeShopTile(
              coffeeShop: _coffeeShopsBloc.coffeeShops[index],
              currentUserLocation: _currentUserLocation,
            );
          }),
    );
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    _currentUserLocation = await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      print(e);
    });
    setState(() {});
  }

  _mapUserDistance(Position currentUserLocation) {
    CoffeeShop coffeeShop;
    Position position;

    for (coffeeShop in _userDistanceMap.keys) {
      _userDistanceMap.putIfAbsent(coffeeShop, () async {
        final query = coffeeShop.address;
        var addresses = await Geocoder.local.findAddressesFromQuery(query);
        position = Position.fromMap(addresses.first.coordinates.toMap());
        return position;
      });
    }
  }

  _account() {}
}
