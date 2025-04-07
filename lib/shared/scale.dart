// 70 /890 * height

final totalHeight = 890;
final totalWidth = 411;

double horizontalPaddingFactor(double width) {
  return width / totalWidth;
}

double verticalPaddingFactor(double height) {
  return height / totalHeight;
}

double responsiveContainerSize(double baseSize, double width, double height) {
  double scaleFactor = (width / totalWidth + height / totalHeight) / 2;
  return baseSize * scaleFactor;
}

double responsiveFontSize(
    double baseSize, double width, double height, double textScaleFactor) {
  double scaleFactor = (width / 411 + height / 890) / 2;
  return baseSize * scaleFactor * textScaleFactor;
}

double responsiveBorderRadius(double baseRadius, double width, double height) {
  double scaleFactor = (width / totalWidth + height / totalHeight) / 2;
  return baseRadius * scaleFactor;
}

// Calculate responsive border width
double responsiveBorderWidth(double baseWidth, double width, double height) {
  double scaleFactor = (width / totalWidth + height / totalHeight) / 2;
  return baseWidth * scaleFactor;
}
