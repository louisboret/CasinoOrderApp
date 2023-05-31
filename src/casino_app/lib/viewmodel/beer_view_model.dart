import 'package:casino_app/model/beer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/apis/api_response.dart';
import '../model/beer_repository.dart';

class BeerViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  final db = FirebaseFirestore.instance;

  var _firebeers = [];
  var _orderedBeers = [];
  int _totalOrderAmount = 0;
  double _totalPrice = 0;
  Beer? _beer;

  ApiResponse get response {
    return _apiResponse;
  }

  List<dynamic> get firebeers {
    return _firebeers;
  }

  List<dynamic> get orderedbeers {
    return _orderedBeers;
  }

  Beer? get beer {
    return _beer;
  }

  int get totalOrderAmount {
    return _totalOrderAmount;
  }

  double get totalPrice {
    return _totalPrice;
  }

  void incrementDrink(dynamic beer) {
    beer["orderedamount"]++;
    var orderedamount = int.tryParse(beer["orderedamount"].toString());
    var price = double.tryParse(beer["data"]["price"].toString());
    beer["total"] = orderedamount! * price!;

    calculateTotalPrice();

    notifyListeners();
  }

  void decrementDrink(dynamic beer) {
    var amount = beer["orderedamount"];
    if (amount > 1) {
      beer["orderedamount"]--;
      var orderedamount = int.tryParse(beer["orderedamount"].toString());
      var price = double.tryParse(beer["data"]["price"].toString());
      beer["total"] = orderedamount! * price!;
    }
    else {
      orderedbeers.remove(beer);
      print(orderedbeers);
    }

    calculateTotalPrice();

    notifyListeners();
  }

  void sendOrder(){
    
  }

  void OrderDrink(dynamic beer) {
    int amount = beer["amount"];

    _totalOrderAmount += amount;
    var price = double.tryParse(beer["data"]["price"].toString());
    bool isnew = true;
    for (var item in orderedbeers) {
      if (item["id"] == beer["id"]) {
        item["orderedamount"] += beer["amount"];
        var orderedamount = int.tryParse(item["orderedamount"].toString());
        item["total"] = orderedamount! * price!;
        isnew = false;
      }
    }

    if (isnew) {
      double total = price! * amount;
      _orderedBeers.add({
        'data': beer["data"],
        'id': beer["id"],
        'orderedamount': amount,
        'total': total
      });
      print(total);
    }

    calculateTotalPrice();

    notifyListeners();
  }

  void calculateTotalPrice() {
    _totalPrice = 0;
    for (var item in orderedbeers) {
      var itemTotal = item["total"];
      _totalPrice += itemTotal;
    }

    notifyListeners();
  }

  Future<void> fetchBeerData() async {
    _apiResponse = ApiResponse.loading('Fetching beers');
    notifyListeners();
    try {
      List<Beer> beerList = await BeerRepository().fetchBeerList();
      _apiResponse = ApiResponse.completed(beerList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchFireDrinks() async {
    _firebeers.clear();
    // ignore: unused_local_variable
    final docRef = db.collection("drinks").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print(docSnapshot.id);
          _firebeers.add(
              {'data': docSnapshot.data(), 'id': docSnapshot.id, 'amount': 1});
          notifyListeners();
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    notifyListeners();
  }

  void setSelectedBeer(Beer? beer) {
    _beer = beer;
    notifyListeners();
  }
}
