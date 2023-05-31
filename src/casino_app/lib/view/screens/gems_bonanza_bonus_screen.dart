import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../model/gem.dart';
import '../../viewmodel/slots_view_model.dart';

class GemsBonanzaBonusScreen extends StatefulWidget {
  const GemsBonanzaBonusScreen(
      {Key? key,
      required this.freespins,
      required this.bet,
      required this.credit})
      : super(key: key);

  final int freespins;
  final int bet;
  final double credit;

  @override
  State<GemsBonanzaBonusScreen> createState() => _GemsBonanzaBonusScreenState();
}

class _GemsBonanzaBonusScreenState extends State<GemsBonanzaBonusScreen> {
  // #region animationvars
  List<Widget> column1 = [];
  List<Widget> column2 = [];
  List<Widget> column3 = [];
  List<Widget> column4 = [];
  List<Widget> column5 = [];
  List<Widget> column6 = [];

  final GlobalKey<AnimatedListState> _listKey1 = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKey2 = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKey3 = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKey4 = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKey5 = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _listKey6 = GlobalKey<AnimatedListState>();

  final Tween<Offset> _offset =
      Tween(begin: const Offset(0, -6), end: const Offset(0, 0));
  final Tween<Offset> _offsetRemove =
      Tween(begin: const Offset(0, -10), end: const Offset(0, -20));

  // #endregion

  // #region vars
  bool isBonus = false;
  Random random = Random();
  double totalWin = 0;
  var takebet = false;
  var collection = <Gem>[];
  var oldCollection = <Gem>[];
  var winningValue = -5;
  var winbusy = false;
  double imagetotal = 0;
  double imageValue = 0;
  var winningImage = '';
  var winText;
  var totalWinText;
  var multiplier = 1;
  double bonusPrice = 0;

  double credit = 0;
  var freespins = 0;
  // #endregion

  @override
  void initState() {
    super.initState();
    freespins = widget.freespins;
    credit = widget.credit;
    _initGems();
  }

  void _initGems() {
    fillCollection();

    for (int i = 0; i < 5; i++) {
      column1.add(_buildItem(i));
    }
    for (int i = 5; i < 10; i++) {
      column2.add(_buildItem(i));
    }
    for (int i = 10; i < 15; i++) {
      column3.add(_buildItem(i));
    }
    for (int i = 15; i < 20; i++) {
      column4.add(_buildItem(i));
    }
    for (int i = 20; i < 25; i++) {
      column5.add(_buildItem(i));
    }
    for (int i = 25; i < 30; i++) {
      column6.add(_buildItem(i));
    }
  }

  Widget _buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset(
        collection[index].img ?? '',
        width: 50,
        height: 50,
      ),
    )
        .animate(
            target: collection[index].value == winningValue ? 1 : 0,
            delay: const Duration(milliseconds: 1000))
        .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
        .then()
        .scale(begin: const Offset(1, 1), end: const Offset(0.8, 0.8));
  }

  Widget _buildRemovedItem(int index, Animation animation) {
    return SlideTransition(
      position: animation.drive(_offsetRemove),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          oldCollection[index].img ?? '',
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  void addAllGems() {
    addGems(column1, _listKey1, 0);
    Future ft = Future(() {});
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 200), () {
        addGems(column2, _listKey2, 5);
      });
    });
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 200), () {
        addGems(column3, _listKey3, 10);
      });
    });
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 200), () {
        addGems(column4, _listKey4, 15);
      });
    });
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 200), () {
        addGems(column5, _listKey5, 20);
      });
    });
    ft = ft.then((_) {
      return Future.delayed(const Duration(milliseconds: 200), () {
        addGems(column6, _listKey6, 25);
      });
    });
  }

  void addGems(
      List<Widget> column, GlobalKey<AnimatedListState> listKey, int counter) {
    Future ft = Future(() {});
    for (int i = 0; i < 5; i++) {
      ft = ft.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          column.insert(i, _buildItem(i + counter));
          AnimatedRemovedItemBuilder builder = (context, animation) {
            return _buildRemovedItem(i, animation);
          };
          listKey.currentState?.removeItem(i, builder);
          listKey.currentState?.insertItem(i);
        });
      });
    }
  }

  void replaceGems(int index) {
    var ind = index;
    var counter = 0;
    var column = column1;
    var listKey = _listKey1;
    if (index >= 5 && index < 10) {
      ind -= 5;
      counter = 5;
      column = column2;
      listKey = _listKey2;
    } else if (index >= 10 && index < 15) {
      ind -= 10;
      counter = 10;
      column = column3;
      listKey = _listKey3;
    } else if (index >= 15 && index < 20) {
      ind -= 15;
      counter = 15;
      column = column4;
      listKey = _listKey4;
    } else if (index >= 20 && index < 25) {
      ind -= 20;
      counter = 20;
      column = column5;
      listKey = _listKey5;
    } else if (index >= 25 && index < 30) {
      ind -= 25;
      counter = 25;
      column = column6;
      listKey = _listKey6;
    }

    replaceGem(ind, counter, column, listKey);
  }

  void replaceGem(int index, int counter, List<Widget> column,
      GlobalKey<AnimatedListState> listKey) {
    setState(() {
      column[index] = _buildItem(index + counter);
    });
  }

  int generateRandom() {
    var amount = 6;
    var bonusChance = 12;

    var rnd = random.nextInt(9) + amount;
    if (rnd == 10) {
      var rnd2 = random.nextInt(bonusChance);
      if (rnd2 != 1) {
        rnd = random.nextInt(9) + 5;
      }
    }
    if (rnd == 14) {
      var rnd2 = random.nextInt(11);
      rnd2 == 1 ? rnd = random.nextInt(3) + 1 : rnd = random.nextInt(9) + 5;
    }

    return rnd;
  }

  fillCollection() {
    collection = <Gem>[];
    for (int i = 0; i < 30; i++) {
      var r = generateRandom();
      var img = 'assets/images/gem$r.png';
      collection.add(Gem(value: r, img: img, index: i));
    }
  }

  spliceCollection(List<int> indexes) {
    indexes.forEach((index) {
      var r = generateRandom();
      collection[index] =
          Gem(img: 'assets/images/gem$r.png', index: index, value: r);
      replaceGems(index);
    });
  }

  Widget getWinText() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            winningImage,
            height: 20,
            width: 20,
          ),
          Text('$totalWin')
        ],
      ),
    );
  }

  calculateWin(int value, int count) {
    double subTotal = 0;

    if (value == 10) {
      return;
    } else {
      subTotal = count * (value * 2) * (widget.bet / 100);
    }

    imagetotal = double.parse(((subTotal * 100) / 100).toStringAsFixed(2));
    totalWin += imagetotal;
    imageValue =
        double.parse(((subTotal * 100) / 100 / count).toStringAsFixed(2));
  }

  Widget getTotalWinText() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text('\$ ${totalWin * multiplier}')],
      ),
    );
  }

  checkMultiplier() {
    if (collection.any((element) =>
        element.value == 1 || element.value == 2 || element.value == 3)) {
      for (int i = 1; i < 4; i++) {
        var col = collection.where((element) => element.value == i);

        if (i == 1) {
          setState(() {
            winningValue = 1;
            multiplier += 2 * col.length;
          });
        } else if (i == 2) {
          setState(() {
            winningValue = 2;
            multiplier += 3 * col.length;
          });
        } else {
          setState(() {
            winningValue = 3;
            multiplier += 5 * col.length;
          });
        }
      }
    }
  }

  void checkWin() async {
    setState(() {
      freespins--;
    });

    checkMultiplier();

    for (var i = 13; i > 4; i--) {
      var currentImg = 'assets/images/gem$i.png';
      var newCol =
          collection.where((element) => element.img == currentImg).toList();
      var count = newCol.length;
      if (count >= 8) {
        setState(() {
          winningValue = i;
          winningImage = currentImg;
        });

        calculateWin(i, count);
        winText = getWinText();
        totalWinText = getTotalWinText();

        var lastindex = 0;
        List<int> indexes = [];

        newCol.forEach((element) {
          var index = collection.indexWhere((gem) => gem.value == i, lastindex);
          indexes.add(index);
          lastindex = index + 1;
        });
        await Future.delayed(const Duration(milliseconds: 3500), () async {
          setState(() {
            winningValue = -5;
          });
          //spliceCollection(indexes);
        });

        credit += totalWin * multiplier;
      }
    }

    var bonusCol = collection.where((element) => element.value == 10).toList();
    var bonusamount = bonusCol.length;

    if(bonusamount == 3) {
      freespins += 3;
    }
    else if(bonusamount == 4) {
      freespins += 5;
    }
    else if(bonusamount > 4){
      freespins += 8;
    }

    if (freespins == 0) {
      Navigator.pop(context, credit);
    }
  }

  void spin() async {
    oldCollection = collection;
    winningValue = -5;
    totalWin = 0;
    fillCollection();

    addAllGems();

    checkWin();
  }

  Widget getColumnWidget(BuildContext context, List<Widget> column,
      GlobalKey<AnimatedListState> listKey) {
    return Expanded(
      child: AnimatedList(
          key: listKey,
          physics: const NeverScrollableScrollPhysics(),
          initialItemCount: 5,
          reverse: false,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
                position: animation.drive(_offset), child: column[index]);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider(
          create: (context) => SlotsViewModel(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                        tag: 'bonusImage',
                        child: Image.asset(
                          'assets/images/big-bonus.png',
                          height: 175,
                          width: 175,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          border: Border.all(color: Colors.grey, width: 2.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Free spins: $freespins'),
                            SizedBox(
                              height: 50,
                              child: Center(
                                child: totalWinText,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Center(
                                child: winText,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    border: Border.all(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(80)),
                                child: Center(
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.black45),
                                        ),
                                        child: Center(
                                            child: Text('x $multiplier'))),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          color: Colors.white),
                      child: SizedBox(
                        height: 300,
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                                child: Row(
                              children: [
                                getColumnWidget(context, column1, _listKey1),
                                getColumnWidget(context, column2, _listKey2),
                                getColumnWidget(context, column3, _listKey3),
                                getColumnWidget(context, column4, _listKey4),
                                getColumnWidget(context, column5, _listKey5),
                                getColumnWidget(context, column6, _listKey6),
                              ],
                            ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          border: Border.all(color: Colors.grey, width: 2.0),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          height: 95,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money),
                                      const SizedBox(width: 6),
                                      Text(credit.toString(),
                                          style: const TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.attach_money),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Bet : ${widget.bet}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          padding: const EdgeInsets.all(25)),
                                      onPressed: () {
                                        spin();
                                      },
                                      child: const Icon(
                                          Icons.keyboard_double_arrow_right),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
