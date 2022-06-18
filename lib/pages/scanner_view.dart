import 'package:desktop_organizer/utils/style.dart';
import 'package:desktop_organizer/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          child: AspectRatio(
            aspectRatio: 4,
            child: MaterialButton(
              onPressed: () {},
              color: purple,
              hoverColor: Colors.deepPurpleAccent.shade100,
              splashColor: Colors.deepPurpleAccent,
              child: text(
                "Start Scan",
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
