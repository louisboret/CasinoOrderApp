import 'package:flutter/material.dart';

import '../../model/beer.dart';

class BeerListWidget extends StatefulWidget {
  final List<Beer> _beerList;
  final Function _function;

  BeerListWidget(this._beerList, this._function);

  @override
  _BeerListWidgetState createState() => _BeerListWidgetState();
}

class _BeerListWidgetState extends State<BeerListWidget> {
  Widget _buildBeerItem(Beer beer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 50,
              height: 50,
              child: Image.network(beer.image ?? '' ), 
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
                    beer.name ?? '',
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
                    beer.breweryName ?? '',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
          ),
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._beerList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            Beer data = widget._beerList[index];
            return InkWell(
              onTap: () {
                if (null != data.breweryName) {
                  widget._function(data);
                }
              },
              child: _buildBeerItem(data),
            );
          },
        ),
      ]),
    );
  }
}
