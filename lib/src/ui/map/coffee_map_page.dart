import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/app_bar_with_pic.dart';
import 'package:cortado_app/src/ui/widgets/cortado_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import '../style.dart';

class CoffeeShopMapPage extends DrawerPage {
  CoffeeShopMapPage(Widget drawer, this.user) : super(drawer);

  final User user;

  @override
  _CoffeeShopMapPageState createState() => _CoffeeShopMapPageState();
}

class _CoffeeShopMapPageState extends State<CoffeeShopMapPage> {
  Set<Marker> _coffeeShopMarkers;
  // ignore: close_sinks
  CoffeeShopsBloc _coffeeShopsBloc;
  BitmapDescriptor pinLocationIcon;
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;

  @override
  void initState() {
    super.initState();
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    setCustomMapPin();
  }

  _searchGoogleMap(String input) {}

  userPositionToLatLng() {
    if (widget.user.currentLocation == null) {
      return LatLng(43.073051, -89.401230);
    }
    return LatLng(widget.user.currentLocation.latitude,
        widget.user.currentLocation.longitude);
  }

  void initCoffeeShopMarkers() {
    Set<Marker> coffeeShopMarkers = Set();
    Marker coffeeShopMarker;
    _coffeeShopsBloc.coffeeShops.forEach((coffeeShop) {
      GeoPoint coffeeShopCoords = coffeeShop.address['coordinates'];
      LatLng coffeeShopPosition =
          LatLng(coffeeShopCoords.latitude, coffeeShopCoords.longitude);
      coffeeShopMarker = Marker(
          icon: pinLocationIcon,
          position: coffeeShopPosition,
          markerId: MarkerId(coffeeShop.id));
      coffeeShopMarkers.add(coffeeShopMarker);
    });
    _coffeeShopMarkers = coffeeShopMarkers;
  }

  void setCustomMapPin() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        'assets/images/icons/white_coffee_bean.png', 50);
    pinLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    initCoffeeShopMarkers();
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
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                markers: _coffeeShopMarkers,
                initialCameraPosition:
                    CameraPosition(target: userPositionToLatLng(), zoom: 16.0),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.setMapStyle(_mapStyle);
                  setState(() {});
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
}
