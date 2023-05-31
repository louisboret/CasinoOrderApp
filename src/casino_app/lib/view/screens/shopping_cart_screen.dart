import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/beer_view_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
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
                    Provider.of<BeerViewModel>(context, listen: false)
                        .decrementDrink(beer);
                  },
                  icon: const Icon(Icons.remove_circle_outline)),
              Text('${beer["orderedamount"]}'),
              IconButton(
                  onPressed: () {
                    Provider.of<BeerViewModel>(context, listen: false)
                        .incrementDrink(beer);
                  },
                  icon: const Icon(Icons.add_circle_outline)),
            ],
          )),
          Text('\$ ${beer["total"]}'),
        ],
      ),
    );
  }

  Widget getBeerWidget(BuildContext context, List<dynamic> beerList) {
    return beerList.isNotEmpty ?
     Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 119, 0),
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                  color: Color.fromARGB(255, 230, 205, 173),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                height: 325,
                child: ListView.separated(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
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
              ),
            ]),
          ),
        ),
      ],
    ) : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 119, 0),
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                  color: Color.fromARGB(255, 230, 205, 173),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                height: 325,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 125),
                    const Text('No orders yet'),
                    ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text('Add drinks'))
                  ],
                ),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    var beers = Provider.of<BeerViewModel>(context).orderedbeers;
    var totalPrice = Provider.of<BeerViewModel>(context).totalPrice;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height:325,child: Expanded(child: getBeerWidget(context, beers))),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      border: Border.all(color: Color.fromARGB(255, 255, 119, 0), width: 2.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Total: \$ $totalPrice')),
                  ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: const Text('Check out'),
                  ),
                )),
          ]),
        ),
      ),
    );
  }
}
