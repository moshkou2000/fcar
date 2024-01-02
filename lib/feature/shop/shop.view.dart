import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../config/theme/theme_color.dart';
import '../shared/shared.module.dart';
import 'shop.argument.dart';

class ShopView extends StatefulWidget {
  const ShopView({required this.arguments, super.key});

  final ShopArgument arguments;

  @override
  State<ShopView> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopView> {
  double _sliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: <Widget>[
                Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  label: _sliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 44,
                    trackShape: GradientRectSliderTrackShape(),
                    thumbColor: ThemeColor.secondary,
                    thumbShape: RectangularSliderThumbShape(
                      thumbHeight: 22,
                      thumbWeight: 22,
                    ),
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 44,
                    trackShape: StripedRectSliderTrackShape(),
                    activeTrackColor: ThemeColor.primary,
                    inactiveTrackColor: Colors.grey[100],
                    thumbColor: ThemeColor.primary,
                    thumbShape: RectangularSliderThumbShape(
                      thumbHeight: 22,
                      thumbWeight: 11,
                    ),
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ),
                FlutterSlider(
                  values: const [30, 60],
                  rangeSlider: true,
                  max: 100,
                  min: 0,
                  visibleTouchArea: true,
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBarHeight: 14,
                    activeTrackBarHeight: 10,
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black12,
                      border: Border.all(width: 3, color: Colors.blue),
                    ),
                    activeTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blue.withOpacity(0.5)),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    // _lowerValue = lowerValue;
                    // _upperValue = upperValue;
                    setState(() {});
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: outlinedButton(
                    onPressed: () {},
                    icon: Icons.ac_unit_sharp,
                    title: 'My Title',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: outlinedButton(
                      onPressed: () {},
                      title: 'My Title',
                      subtitle: 'This is a subtitle, sample of the besht :D'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: outlinedButton(
                    title: 'Balance',
                    subtitle: '\$366',
                    titleBold: false,
                    subtitleBold: true,
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: outlinedButton(
                      width: 118,
                      title: 'Balance',
                      subtitle: '\$366',
                      titleBold: false,
                      subtitleBold: true,
                      onPressed: () {},
                      color: Colors.blue[400]!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textButton(
                      width: 118,
                      title: 'Text Button',
                      subtitle: 'This is a sample text button...',
                      onPressed: () {},
                      color: Colors.blue[400]!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: outlinedButton(
                    width: double.infinity,
                    title: 'Sign In',
                    onPressed: () {},
                    color: Colors.blue[300]!,
                    alignment: CrossAxisAlignment.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
