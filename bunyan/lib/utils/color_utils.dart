import 'package:flutter/material.dart';

/// Parses an RGBA string and converts it to a Color object.
/// The string format should be "R,G,B,A" (e.g., "255, 0, 0, 1").
Color parseRgbaToColor(String rgbaString) {
  try {
    // Split the string by commas and trim any extra spaces
    List<String> rgba = rgbaString.split(',');

    // Parse each component as an integer (for R, G, B) and a double (for A)
    int red = int.parse(rgba[0].trim());
    int green = int.parse(rgba[1].trim());
    int blue = int.parse(rgba[2].trim());
    double alpha = double.parse(rgba[3].trim());

    // Ensure values are within valid color ranges
    red = red.clamp(0, 255);
    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);
    alpha = alpha.clamp(0.0, 1.0);

    // Return a Color object
    return Color.fromRGBO(red, green, blue, alpha);
  } catch (e) {
    return Colors.transparent;
  }
}

const Color primaryGreen = Color(0xFF0CAF60);
const Color primaryRed = Color(0xFFFF6A55);
const Color white = Color(0xFFF0F0F0);
const Color blackish = Color(0xFF323232);
const Color greyish = Color(0xFFC8C8C8);
const Color lightGrey = Color(0xFF9C9A9A);
