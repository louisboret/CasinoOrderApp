import 'package:flutter/material.dart';

class BigCard extends StatefulWidget {
  const BigCard({
    super.key,
    required this.text,
    required this.icon,
    required this.pos,
  });

  final String text;
  final Icon icon;
  final String pos;

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  double tl = 12;

  double tr = 12;

  double bl = 12;

  double br = 12;

  @override
  Widget build(BuildContext context) {

    switch(widget.pos) {
      case 'top':
        bl = 0;
        br = 0;
        break;
      case 'bottom':
        tl = 0;
        tr = 0;
        break;
      case 'middle':
        tl = 0;
        tr = 0;
        bl = 0;
        br = 0;
        break;
      default:
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tl),
                topRight: Radius.circular(tr),
                bottomLeft: Radius.circular(bl),
                bottomRight: Radius.circular(br)),
            border: Border.all(color: Colors.grey, width: 2.0),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              widget.icon,
              const SizedBox(width: 6),
              Text(widget.text),
            ],
          ),
        ),
      ),
    );
  }
}
