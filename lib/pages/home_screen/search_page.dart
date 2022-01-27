import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/pages/home_screen/details_page.dart';
import 'package:garage_locator/provider/size-config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.nearestCity})
      : super(key: key);
  final String nearestCity;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ///____________________________________________________________________________VARIABLES
  bool isLoading = true;
  var databaseInstance = FirebaseFirestore.instance;
  List<String> garageNames = [];
  List<String> ratings = [];
  List<String> garageAddress = [];
  List<String> openHours = [];
  List<String> mapNames =[];

  ///____________________________________________________________________________DISPOSE
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ///____________________________________________________________________________

  ///____________________________________________________________________________INIT STATE
  @override
  void initState() {
    // TODO: implement initState
    getGarageAddress();
    getGarageMapName();
    getGarageName();
    getGarageRating();
    getOpenHours();
    super.initState();
  }

  ///_____________________________________________________________________________Get Data
  Future getGarageName() async {
    databaseInstance
        .collection('garages')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()!['garages'])) {
          setState(() {
            String nameData = element;
            garageNames.add(nameData);
          });
        }
      });
    });
  }
  Future getGarageMapName() async {
    databaseInstance
        .collection('garages')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()!['map_name'])) {
          setState(() {
            String nameData = element;
            mapNames.add(nameData);
          });
        }
      });
    });
  }

  Future getGarageAddress() async {
    databaseInstance
        .collection('garages')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()!['address'])) {
          setState(() {
            String data = element;
            garageAddress.add(data);
          });
        }
      });
    });
  }

  Future getGarageRating() async {
    databaseInstance
        .collection('garages')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()!['rating'])) {
          setState(() {
            String data = element;
            ratings.add(data);
          });
        }
      });
    });
  }

  Future getOpenHours() async {
    databaseInstance
        .collection('garages')
        .doc(widget.nearestCity)
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value.data()!['open_hours'])) {
          setState(() {
            String data = element;
            openHours.add(data);
          });
        }
      });
    });
  }

  ///____________________________________________________________________________WIDGET BUILD
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeH!;
    double mWidth = SizeConfig.blockSizeW!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: mHeight * 10,
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: mHeight * 3.5,
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const Divider(color: Colors.black12),
              FutureBuilder(
                  future: getGarageAddress(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return loadingBackground(mHeight, mWidth);
                    } else {
                      return ListView.builder(
                          itemCount: garageAddress.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return buildSearchBox(
                                garageNames[index],
                                garageAddress[index],
                                ratings[index],
                                openHours[index],
                                mHeight,
                                mWidth,
                                index);
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future loadSearchData() async {}

  ///_____________________________________________________________________________Build Game Box
  buildSearchBox(String _garageName, String _garageAddress, String _rating,
          String _openHours, double _mHeight, double _mWidth, int index) =>
      GestureDetector(
        onTap: () {
          setState(() {});
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => DetailsPage(
                    mapName: mapNames[index],
                    nearestCity: widget.nearestCity,
                    garageAddress: garageAddress[index],
                    garageName: garageNames[index],
                    openHours: openHours[index],
                  )));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          height: _mHeight * 10,
          width: _mWidth,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _rating,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.star,
                      color: linkColor,
                      size: _mHeight * 3.2,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_garageName,
                      style: TextStyle(
                          fontSize: _mHeight * 2.2,
                          fontWeight: FontWeight.w700)),
                  Text(_garageAddress,
                      style: TextStyle(
                          fontSize: _mHeight * 2, fontWeight: FontWeight.w600)),
                  Text(_openHours,
                      style: TextStyle(
                          fontSize: _mHeight * 1.8,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: appGreen,
                size: _mHeight * 3.7,
              )
            ],
          ),
        ),
      );
}

Widget loadingBackground(double mHeight, double mWidth) => SizedBox(
      height: mHeight * 60,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: mWidth * 60,
            width: mWidth * 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/icongl.png'),
                  fit: BoxFit.contain,
                  opacity: 0.6,
                )),
          ),
          SizedBox(height: mHeight * 5),
          CircularProgressIndicator(color: appGreen)
        ],
      ),
    );
