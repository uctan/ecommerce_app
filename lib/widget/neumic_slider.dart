import 'package:flutter/material.dart';

class NeumicSlider extends StatefulWidget {
  const NeumicSlider({super.key});

  @override
  State<NeumicSlider> createState() => _NeumicSliderState();
}

class _NeumicSliderState extends State<NeumicSlider> {
  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: 5,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}
