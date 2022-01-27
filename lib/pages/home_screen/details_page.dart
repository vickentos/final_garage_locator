import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/provider/size-config.dart';
import 'package:garage_locator/widgets/my_background.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      required this.mapName,
      required this.nearestCity,
      required this.openHours,
      required this.garageAddress,
      required this.garageName})
      : super(key: key);
  final String mapName;
  final String nearestCity;
  final String garageAddress;
  final String openHours;
  final String garageName;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var databaseInstance = FirebaseFirestore.instance;
  List<String> imageList = [];
  LatLng garageGeoCode = LatLng(1, 36);
  late BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  final Completer<GoogleMapController> _pController = Completer();

  Future getImages() async {
    databaseInstance
        .collection('images')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()![widget.mapName])) {
          setState(() {
            String data = element;
            imageList.add(data);
          });
        }
      });
    });
  }

  Future getGeoCode() async {
    databaseInstance
        .collection('geocode')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        garageGeoCode = value.data()![widget.mapName] as LatLng;
      });
    });
  }


  @override
  void initState() {
    getGeoCode();
    getImages();
    setCustomMapPin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeH!;
    return MyBackground(
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: mHeight * 10,
          centerTitle: true,
          leading: InkWell(
            splashColor: Colors.amber,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: mHeight * 3.4,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          title: Text(
            widget.garageName,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: appGreen,
                fontSize: mHeight * 2.5),
          ),
        ),
        body: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(autoPlay: true, height: mHeight * 25),
              items: imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                                image: NetworkImage(i), fit: BoxFit.cover)));
                  },
                );
              }).toList(),
            ),
            Container(
              color: appGreen.withOpacity(0.6),
              width: double.infinity,
              height: mHeight * 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Address:  ' + widget.garageAddress,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: mHeight * 2),
                  ),
                  Text(
                    'Open Hours:  ' + widget.openHours,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: mHeight * 2),
                  )
                ],
              ),
            ),
            SizedBox(
              height: mHeight * 50,
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: garageGeoCode, zoom: 15),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: false,
              ),
            )
          ],
        ),
      )),
    );
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    setState(() {
      _pController.complete(_cntlr);
      _markers.add(Marker(
          markerId: const MarkerId('<MarkerId>'),
          position: garageGeoCode,
          icon: pinLocationIcon));
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'lib/assets/placemacker.png');
  }
}

///Name, Images, Contact Info, Location with map, follow btn
