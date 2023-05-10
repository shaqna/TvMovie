import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kPrussianBlue,
                  child: const Center(child: Icon(Icons.image)),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoYellow,
                  child: const Text(
                    'The TvMovie App',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
