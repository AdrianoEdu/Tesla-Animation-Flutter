import 'package:flutter/material.dart';
import 'package:teslacaranimation/home_controller.dart';

import '../../../constanins.dart';
import '../../../constants/Images.dart';
import '../tmp_btn/tmp.btn.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key? key,
    required HomeController controller,
  }) : _controller = controller,
       super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  svgSrc: coolShapeImagePath,
                  title: 'Cool',
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(width: defaultPadding,),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: heatShapeImagePath,
                  title: 'Heat',
                  activeColor: redColor,
                  press: _controller.updateCoolSelectedTab,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_up, size: 48, color: Colors.white,),
              ),
              const Text('29' + '\u2103' , style: TextStyle(fontSize: 86, color: Colors.white),),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down, size: 48, color: Colors.white,),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'CURRENT TEMPERATURE',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'INSIDE',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '20' + '\u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'INSIDE',
                    style: TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '20' + '\u2103',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
