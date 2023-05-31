import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/slots_view_model.dart';

class SlotActionMenu extends StatefulWidget {
  SlotActionMenu({
    super.key,
  });

  @override
  State<SlotActionMenu> createState() => _SlotActionMenuState();
}

class _SlotActionMenuState extends State<SlotActionMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 5,
    );
    
    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var viewModel = context.watch<SlotsViewModel>();

    var credit = Provider.of<SlotsViewModel>(context, listen: true).credit;

    return SizedBox(
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
                        Text(credit.toString(), style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.attach_money),
                        SizedBox(width: 6),
                        Text(
                          'Bet : 100',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      viewModel.manipulateList();
                    },
                    child: const Text('test')),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25)),
                      onPressed: () async {
                        await viewModel.spin();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: controller.value),
                        child: const Icon(Icons.keyboard_double_arrow_right)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
