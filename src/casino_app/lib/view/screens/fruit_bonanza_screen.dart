import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/slots_view_model.dart';
import '../widgets/slot_actions_widget.dart';
import '../widgets/slot_game_widget.dart';

class FruitBonanzaScreen extends StatefulWidget {
  const FruitBonanzaScreen({super.key});

  @override
  State<FruitBonanzaScreen> createState() => _FruitBonanzaScreenState();
}

class _FruitBonanzaScreenState extends State<FruitBonanzaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Bonanza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider(
          create: (context) => SlotsViewModel(),
          child: Column(
            children: [
              SlotGame(),
              SlotActionMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
