
import 'beer.dart';

class BeerMockRepository {
  
  var beers = List<Beer>.filled(3, Beer(), growable: true);


  

  List<Beer> fetchBeerList() {
    
    beers[0] = Beer(breweryName: 'Vanderghindste', image: 'https://shuttle-storage.s3.amazonaws.com/omer/system/resized/images/beer/packshots/bottles/omer%20bottle_152x0.png', name: 'Omer');
    beers[1] = Beer(breweryName: 'Vanhonsebrouck', image: 'https://imagestoreretrieval.aspos.nl/Product/Front/601826/22269e8e-adbe-4e8f-8178-e771124dd908.png', name: 'Filou');
    beers[2] = Beer(breweryName: 'Vanhonsebrouck', image: 'https://www.nevejan.eu/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/k/a/kasteel_fles33tripel_lr.jpg', name: 'Kasteelbier Tripel');
    return beers;
  }
}
