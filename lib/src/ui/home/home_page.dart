/* import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:cortado_app/src/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../repositories/coffee_shop_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String _title = "Coffee Shops";
  TabController _tabController;
  CoffeeShopRepository _coffeeShopRepository;
  CoffeeShopsBloc _coffeeShopsBloc;

  Position _currentUserLocation;
  Geolocator geolocator = Geolocator();

  int _selectedIndex = 0;

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _coffeeShopRepository = CoffeeShopRepository();
    _coffeeShopsBloc = CoffeeShopsBloc(_coffeeShopRepository);
    _coffeeShopsBloc.add(GetCoffeeShops());
    _getCurrentLocation();
    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      _currentUserLocation = position;
    });
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
        body: BlocBuilder(
            bloc: _coffeeShopsBloc,
            builder: (BuildContext context, state) {
              if (state is CoffeeShopsLoadingState) {
                showSnackbar(context, Text("Local coffee shops loading."));
              }
              return Center(
                  // TODO
                  // Make pages with bottom nav widgets
                  child:
                      (_selectedIndex == 0) ? _coffeeShopList() : _account());
            }),
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
      color: Colors.grey[200],
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
    try {
      _currentUserLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      _currentUserLocation = null;
    }
  }

  _account() {}
}
 */
