import 'package:casino_app/view/widgets/slot_thumbnail_widget.dart';
import 'package:casino_app/viewmodel/slots_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/big_card_widget.dart';

class SlotsScreen extends StatefulWidget {
  const SlotsScreen({super.key});

  @override
  _SlotsScreenState createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  //var appstate = context.watch<MyAppState>();

  @override
  Widget build(BuildContext context) {
    var credit = Provider.of<SlotsViewModel>(context, listen: true).credit;
    var txtCredit = credit.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Slots')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox.expand(
          child: Wrap(
              spacing: 15,
              runSpacing: 15,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.start,
              alignment: WrapAlignment.center,
              children: [
                BigCard(
                  icon: const Icon(Icons.attach_money),
                  text: txtCredit,
                  pos: 'e',
                ),
                Thumbnail(
                  image: 'assets/images/gemsbonanza.webp',
                  gameRoute: '/gemsbonanza',
                ),
                Thumbnail(
                    image: 'assets/images/sweetbonanza.jpg',
                    gameRoute: '/gemsbonanza'),
                Thumbnail(
                    image: 'assets/images/fruitbonanza.webp',
                    gameRoute: '/gemsbonanza'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'test');
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                      child: const SizedBox(
                          width: 170,
                          height: 170,
                          child: Center(
                              child: Text('Coming soon...',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center))),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
