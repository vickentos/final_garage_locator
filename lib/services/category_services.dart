import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garage_locator/model/categories.dart';


class DatabaseManager {

  FirebaseFirestore? _instance;

  final List<Category> _categories = [];
  final List<String> imageList = [];
  List<Category> getCategories() {
    return _categories;
  }

  Future<void> getCategoriesCollectionFromFirebase(String nearbyCity) async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance!.collection('garages');

    DocumentSnapshot snapshot = await categories.doc(nearbyCity).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      var categoriesData = data['categories'] as List<dynamic>;
      for (var catData in categoriesData) {
        Category cat = Category.fromJson(catData);
        _categories.add(cat);
      }
    }
  }

  Future getImages(String city, String mapName)async{
    _instance = FirebaseFirestore.instance;
    CollectionReference images = _instance!.collection('images');
    DocumentSnapshot snapshot = await images.doc(city).get();


  }

}