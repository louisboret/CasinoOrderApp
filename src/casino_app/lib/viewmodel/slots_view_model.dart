import 'dart:math';

import 'package:flutter/cupertino.dart';

class SlotsViewModel extends ChangeNotifier {
  double _credit = 15000;

  bool _isBonus = false;
  Random random = new Random();
  var totalWin = 0;
  var takebet = false;
  var bet = 100;
  var freeSpins = 0;
  var collection = <String>[];
  var _list;

  double get credit {
    return _credit;
  }

  bool get isBonus {
    return _isBonus;
  }

  dynamic get list => _list;

  set list(dynamic value) {
    _list = value;
    notifyListeners();
  }

  void takeBet(double bet) {
    _credit -= bet;
  }

  void addWin(double winAmount) {
    _credit += winAmount;
  }

  manipulateList() {
    collection[2] = 'assets/images/gem10.png';
    list = List.generate(30, (index) {
      return Image.asset(collection[index]);
    });
  }

  int generateRandom() {
    var amount = 0;
    var bonusChance = 0;

    isBonus ? amount = 6 : amount = 5;
    isBonus ? bonusChance = 15 : bonusChance = 8;

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
    collection = [];
    return List.generate(30, (index) {
      var r = generateRandom();
      var img = 'assets/images/gem$r.png';
      collection.add(img);
      return Image.asset(img);
    });
  }

  fillCollectionAnimated(BuildContext context, List<Animation<Offset>> animations) {
    collection = [];
    return List.generate(30, (index) {
      var r = generateRandom();
      var img = 'assets/images/gem$r.png';
      collection.add(img);
      return AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: 0,
            top: MediaQuery.of(context).size.height *
                animations[index].value.dy,
            child: Image.asset(collection[index]),
          );
    });
  }

  Future spin() async {
    //disableSpin = true;
    totalWin = 0;
    // if (takebet) {
    //   !isBonus ? _credit -= bet : freeSpins--;
    // }

    list = fillCollection();

    //disableSpin = false;

    if (takebet) {
      // await checkWin();
    }

    takebet = true;
    //await this.checkBet();

    //this.checkBonus();
  }

  Future spinAnimation(BuildContext context, List<Animation<Offset>> animations) async {
    //disableSpin = true;
    totalWin = 0;
    // if (takebet) {
    //   !isBonus ? _credit -= bet : freeSpins--;
    // }

    list = fillCollectionAnimated(context, animations);

    //disableSpin = false;

    if (takebet) {
      // await checkWin();
    }

    takebet = true;
    //await this.checkBet();

    //this.checkBonus();
  }
}
