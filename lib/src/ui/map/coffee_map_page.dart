import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/app_bar_with_pic.dart';
import 'package:cortado_app/src/ui/widgets/cortado_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../style.dart';

class CoffeeShopMapPage extends DrawerPage {
  CoffeeShopMapPage(Widget drawer, this.user) : super(drawer);
  final User user;
  @override
  _CoffeeShopMapPageState createState() => _CoffeeShopMapPageState();
}

class _CoffeeShopMapPageState extends State<CoffeeShopMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        body: Column(
          children: <Widget>[
            CustomScrollView(shrinkWrap: true, slivers: <Widget>[
              AppBarWithImage(
                actions: coffeeRedemptionWidget(widget.user),
                image: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/map.png")))),
                lower: CortadoSearchBar(
                  onSubmitted: _searchGoogleMap,
                ),
              ),
            ]),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.setMapStyle(_mapStyle);
                },
              ),
            ),
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: widget.drawer,
        ));
  }

  _searchGoogleMap(String input) {}

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
}
