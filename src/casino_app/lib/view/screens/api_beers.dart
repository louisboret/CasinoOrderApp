import 'package:casino_app/model/beer.dart';
import 'package:casino_app/model/beer_mock_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/apis/api_response.dart';
import '../../viewmodel/beer_view_model.dart';
import '../widgets/beer_list_widget.dart';

class ApiBeersScreen extends StatefulWidget {
  const ApiBeersScreen({super.key});

  @override
  _ApiBeersScreenState createState() => _ApiBeersScreenState();
}

class _ApiBeersScreenState extends State<ApiBeersScreen> {
  Widget getBeerWidget(BuildContext context, ApiResponse apiResponse) {
    List<Beer>? beerList = apiResponse.data as List<Beer>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: BeerListWidget(beerList!, (Beer beer) {
                Provider.of<BeerViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.ERROR:
      var mockBeers = BeerMockRepository().fetchBeerList();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 8,
              child: BeerListWidget(mockBeers, (Beer beer) {
                Provider.of<BeerViewModel>(context, listen: false);
              }),
            ),
          ],
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('all beers'),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BeerViewModel>(context, listen: false);
      Provider.of<BeerViewModel>(context, listen: false).fetchBeerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<BeerViewModel>(context).response;

    return Scaffold(
      onDrawerChanged: (f) {},
      appBar: AppBar(
        title: const Text('API beers'),
        
      ),
      body: Column(
        children: <Widget>[
          
          Expanded(child: getBeerWidget(context, apiResponse)),
        ],
      ),
    );
  }
}
