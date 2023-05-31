import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/slots_view_model.dart';
import '../widgets/slot_game_widget.dart';

class GemsBonanzaScreen extends StatefulWidget {
  const GemsBonanzaScreen({super.key});

  @override
  State<GemsBonanzaScreen> createState() => _GemsBonanzaScreenState();
}

class _GemsBonanzaScreenState extends State<GemsBonanzaScreen> {
  @override
  Widget build(BuildContext context) {
    //var credit = Provider.of<SlotsViewModel>(context, listen: true).credit;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gems Bonanza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ChangeNotifierProvider(
          create: (context) => SlotsViewModel(),
          child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SlotGame(),
                ],
              ),
        ),
      ),
    );
  }
}
