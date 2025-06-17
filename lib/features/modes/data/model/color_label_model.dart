import 'dart:ui';

class ColorOption {
  final String label;
  final Color color;
  final int id;
  double? intensity;
  double? brightness;
  ColorOption({
    required this.label,
    required this.color,
    required this.id,
    this.intensity = 0,
    this.brightness = 0,
  });
}
