import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../model/Tyre.dart';

class TyrePsiCard extends StatelessWidget {
  const TyrePsiCard({
    Key? key,
    required this.isBottomTwoTyre,
    required this.tyre
  }): super(key: key);

  final bool isBottomTwoTyre;
  final Tyre tyre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: tyre.isLowPressure ?? false ? redColor.withOpacity(0.1) : Colors.white10,
        border: Border.all(
          color: tyre.isLowPressure ?? false ? redColor : primaryColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular((6))),

      ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getCompnentLayout(isBottomTwoTyre, context),
      ),
    );
  }

  List<Widget> getCompnentLayout(bool isBottomTwoTyre, BuildContext context) {
    if(isBottomTwoTyre) {
      return <Widget>[
        lowPressureText(context),
        const Spacer(),
        psiText(context, psi: tyre.psi.toString()),
        const SizedBox(height: defaultPadding),
        Text(
          '${tyre.temp ?? '0'}\u2103',
          style: const TextStyle(fontSize:16 , color: Colors.white),
        ),
      ];
    }

    return <Widget>[
        psiText(context, psi: tyre.psi.toString()),
        const SizedBox(height: defaultPadding),
        Text(
          '${tyre.temp ?? '0'}\u2103',
          style: const TextStyle(fontSize:16 , color: Colors.white),
        ),
        const Spacer(),
        lowPressureText(context),
    ];
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
