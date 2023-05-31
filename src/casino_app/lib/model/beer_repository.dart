import 'package:casino_app/model/services/base_service.dart';
import 'package:casino_app/model/services/beer_service.dart';

import 'beer.dart';

class BeerRepository {
  BaseService _beerService = BeerService();

  Future<List<Beer>> fetchBeerList() async {
    dynamic response = await _beerService.getResponse('beers');
    final jsonData = response as List;
    List<Beer> beerList =
        jsonData.map((tagJson) => Beer.fromJson(tagJson)).toList();
    return beerList;
  }
}
