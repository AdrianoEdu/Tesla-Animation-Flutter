import 'package:flutter/material.dart';

import '../../../constanins.dart';
import '../../../model/TyrePsi.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyrePsi,
  }): super(key: key);

  final bool isBottomTwoTyre;
  final TyrePsi tyrePsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: tyrePsi.isLowPressure ? redColor.withOpacity(0.1) : Colors.white10,
        border: Border.all(
          color: tyrePsi.isLowPressure ? redColor : primaryColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular((6))),

      ),
    child: isBottomTwoTyre
    ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lowPressureText(context),
        const Spacer(),
        psiText(context, psi: tyrePsi.psi.toString()),
        const SizedBox(height: defaultPadding),
        Text(
          '${tyrePsi.temp}\u2103',
          style: const TextStyle(fontSize:16 , color: Colors.white),
        ),
      ]
    )
    : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        psiText(context, psi: tyrePsi.psi.toString()),
        const SizedBox(height: defaultPadding),
        Text(
          '${tyrePsi.temp}\u2103',
          style: const TextStyle(fontSize:16 , color: Colors.white),
        ),
        const Spacer(),
        lowPressureText(context),
      ],
    ),
    );
  }

  Column lowPressureText(BuildContext context) {
    return Column(
      children: [
        Text(
            'LOW',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
          ),
          const Text(
          'PRESSURE',
          style: TextStyle(fontSize: 20, color: Colors.white),
        )
      ],
    );
  }

  Text psiText(BuildContext context, {required String psi}) {
    return Text.rich(
        TextSpan(
          text: psi,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
          children: const [
            TextSpan(
              text: 'psi',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              )
            ),
          ],
        ),
      );
  }
}
