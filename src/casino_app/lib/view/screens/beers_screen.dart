import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/beer_view_model.dart';

import 'package:badges/badges.dart' as badges;

class BeersScreen extends StatefulWidget {
  const BeersScreen({super.key});

  @override
  _BeersScreenState createState() => _BeersScreenState();
}

class _BeersScreenState extends State<BeersScreen> {
  Widget _buildBeerItem(dynamic beer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 50,
              height: 50,
              child: Image.network(beer["data"]["image"] ?? ''),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    beer["data"]["name"] ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '\$ ${beer["data"]["price"] ?? 0}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
          Expanded(
              child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    var amount = beer["amount"];
                    if (amount > 0) {
                      setState(() {
                        beer["amount"]--;
                      });
                    }
                  },
                  icon: Icon(Icons.remove_circle_outline)),
              Text('${beer["amount"]}'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      beer["amount"]++;
                    });
                  },
                  icon: Icon(Icons.add_circle_outline)),
            ],
          )),
          ElevatedButton(
              onPressed: () {
                Provider.of<BeerViewModel>(context, listen: false)
                    .OrderDrink(beer);
              },
              child: const Text('order')),
        ],
      ),
    );
  }

  Widget getBeerWidget(BuildContext context, List<dynamic> beerList) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: beerList.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  var data = beerList[index];
                  return InkWell(
                    onTap: () {},
                    child: _buildBeerItem(data),
                  );
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BeerViewModel>(context, listen: false);
      Provider.of<BeerViewModel>(context, listen: false).fetchFireDrinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalOrderAmount = Provider.of<BeerViewModel>(context).totalOrderAmount;
    var beers = Provider.of<BeerViewModel>(context).firebeers;
    return Scaffold(
      onDrawerChanged: (f) {},
      appBar: AppBar(
        title: const Text('Beers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'API beers',
            onPressed: () {
              Navigator.pushNamed(context, '/apibeers');
            },
          ),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -3, end: -1),
            showBadge: true,
            ignorePointer: false,
            onTap: () {},
            badgeContent: Text('$totalOrderAmount'),
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.circle,
              badgeColor: Colors.blue,
              padding: const EdgeInsets.all(7),
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 102, 0), width: 1),
              badgeGradient: const badges.BadgeGradient.linear(
                colors: [Colors.orange, Color.fromARGB(255, 255, 77, 0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              elevation: 0,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_basket_outlined),
              tooltip: 'orderlist',
              onPressed: () {
                Navigator.pushNamed(context, '/shoppingcart');
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: getBeerWidget(context, beers)),
        ],
      ),
    );
  }
}
