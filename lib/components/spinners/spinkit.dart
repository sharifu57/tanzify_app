import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tanzify_app/pages/constants.dart';

class WaveSpinKit extends StatelessWidget {
  const WaveSpinKit({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: SpinKitWave(
        color: Constants.primaryColor,
        size: 20.0,

        // controller: AnimationController(
        //     vsync: this,
        //     duration: const Duration(milliseconds: 1200)),
      ),
    );
  }
}
