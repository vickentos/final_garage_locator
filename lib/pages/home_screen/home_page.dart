
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/pages/home_screen/search_page.dart';
import 'package:garage_locator/provider/size-config.dart';
import 'package:garage_locator/widgets/home_menu.dart';
import 'package:garage_locator/widgets/my_background.dart';
import 'package:garage_locator/widgets/search_btn.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///___________________________________________________________________________VARIABLES
  LatLng _initialcameraposition = LatLng(-1.27, 36.81);
  late GoogleMapController _controller;
  final Location _location = Location as Location;
  late BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  final Completer<GoogleMapController> _pController = Completer();


  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'lib/assets/placemacker.png');
  }
  ///____________________________________________________________________________Determine position

  void _onMapCreated(GoogleMapController _cntlr) {
    _pController.complete(_cntlr);
    setState(() {
      _controller = _cntlr;
      _markers.add(
          Marker(
              markerId: const MarkerId('<MarkerId>'),
              position: _initialcameraposition,
              icon: pinLocationIcon
          ));
      _location.onLocationChanged.listen((l) {
        setState(() {
          _initialcameraposition = LatLng(l.latitude!, l.longitude!);
        });
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
      });
    });
  }

  ///_____________________________________________________________________________INIT STATE
  @override
  initState() {
    requestLocation();
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'lib/assets/placemacker.png').then((onValue) {
      pinLocationIcon = onValue;
    });
    setCustomMapPin();
    super.initState();
  }

  Future requestLocation() async {}

  ///_____________________________________________________________________________DISPOSE METHOD
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  ///____________________________________________________________________________WIDGET BUILD
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeH!;
    double mWidth = SizeConfig.blockSizeW!;
    return MyBackground(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        height: double.infinity,
                        width: double.infinity,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: _initialcameraposition, zoom: 15),
                          mapType: MapType.normal,
                          onMapCreated: _onMapCreated,
                          myLocationEnabled: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, left: 16.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: HomeMenuLogo(
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      color: appGreen.withOpacity(0.6),
                                      height: mHeight * 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            FirebaseAuth.instance.signOut();
                                          });

                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.arrow_circle_down,
                                              color: whiteBackground,
                                              size: mHeight * 3.7,
                                            ),
                                            title: Text(
                                              'Sign Out.',
                                              style: TextStyle(
                                                fontSize: mHeight * 2.8,
                                                color: whiteBackground,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                            mHeight: mHeight,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: SearchBtn(
                              onPressed: () => searchGarage,
                              mHeight: mHeight,
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void searchGarage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage(nearestCity: 'Nairobi')));
  }
}
