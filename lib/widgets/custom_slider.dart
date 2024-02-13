import 'package:flutter/material.dart';
import 'package:oasis_uz_mobile/constants/app_color.dart';

class CustomSliderTheme extends StatelessWidget {
  final Widget child;

  const CustomSliderTheme({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 10;
    const double tickMarkRadius = 8;

    final activeColor = mainColor;
    const inactiveColor = Color.fromRGBO(109, 114, 120, 1);

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 8,
        rangeThumbShape: const RoundRangeSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
        rangeTickMarkShape:
            const RoundRangeSliderTickMarkShape(tickMarkRadius: tickMarkRadius),
        inactiveTickMarkColor: inactiveColor,
        inactiveTrackColor: inactiveColor,
        thumbColor: activeColor,
        activeTrackColor: activeColor,
        activeTickMarkColor: activeColor,
      ),
      child: child,
    );
  }
}
