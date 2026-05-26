import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String selectedCategory = 'Distance';
  Set<String> selectedDistance = {};
  RangeValues priceRange = RangeValues(4, 6);
  String? selectedCity;
  Set<String> selectedRatings = {};
  bool _isCityExpanded = false;

  List<String> get _filterCategories => [
        'Distance',
        'Price Range',
        'City',
        'Rating',
      ];

  List<String> get _distanceOptions => [
        'Less than 2km',
        'Less than 5km',
        'Less than 10km',
      ];

  List<String> get _cityOptions => [
        'Chandanagar',
        'Kukatpally',
        'Madhapur',
        'Madinaguda',
        'Miyapur',
        'Hi-Tech City',
      ];

  List<String> get _ratingOptions => [
        '5 Star',
        '4 & above',
        '3 & above',
        '2 & above',
      ];

  int get _selectedFilterCount {
    int count = 0;
    if (selectedDistance.isNotEmpty) count++;
    if (priceRange.start != 4 || priceRange.end != 6) count++;
    if (selectedCity != null) count++;
    if (selectedRatings.isNotEmpty) count++;
    return count;
  }

  void _resetAllFilters() {
    setState(() {
      selectedDistance.clear();
      priceRange = RangeValues(4, 6);
      selectedCity = null;
      selectedRatings.clear();
      _isCityExpanded = false;
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'distance': selectedDistance,
      'priceRange': priceRange,
      'city': selectedCity,
      'ratings': selectedRatings,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Reduced height for a more compact bottom sheet
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle - black line as in the design
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          Text(
            'Filters',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 24),
          // Two-column layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column - Filter categories
                Container(
                  width: 120,
                  color: AppColors.backgroundGrey,
                  child: ListView.builder(
                    itemCount: _filterCategories.length,
                    itemBuilder: (context, index) {
                      final category = _filterCategories[index];
                      final isSelected = selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.backgroundWhite
                                : Colors.transparent,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: 
                                   FontWeight.w400,
                              color: AppColors.textPrimaryBlack,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Right column - Filter options
                Expanded(
                  child: Container(
                    color: AppColors.backgroundWhite,
                    child: _buildFilterOptions(),
                  ),
                ),
              ],
            ),
          ),
          // Bottom action buttons
          Container(
            padding: EdgeInsets.all(16),
            // No top border line above the buttons for a cleaner look
            color: AppColors.backgroundWhite,
            child: Row(
              children: [
                // Reset All button
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetAllFilters,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryOrange),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Reset All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Apply Filters button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: Text(
                      'Apply Filters (${_selectedFilterCount})',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    switch (selectedCategory) {
      case 'Distance':
        return _buildDistanceOptions();
      case 'Price Range':
        return _buildPriceRangeOptions();
      case 'City':
        return _buildCityOptions();
      case 'Rating':
        return _buildRatingOptions();
      default:
        return SizedBox();
    }
  }

  Widget _buildDistanceOptions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _distanceOptions.length,
      itemBuilder: (context, index) {
        final option = _distanceOptions[index];
        final isSelected = selectedDistance.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedDistance.remove(option);
              } else {
                selectedDistance.add(option);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primaryOrange
                        : AppColors.textPrimaryBlack,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriceRangeOptions() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title styled similar to the design (slightly emphasized)
          Text(
            'Price',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 24),
          // Price range bar styled to match the design
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              rangeTrackShape: const RectangularRangeSliderTrackShape(),
              activeTrackColor: const Color(0xFF168A40),
              inactiveTrackColor: const Color(0xFFE2F3E7),
              // Solid white thumbs with no colored halo
              thumbColor: Colors.white,
              overlayColor: Colors.transparent,
              // White value indicator boxes above thumbs with dark text
              valueIndicatorColor: Colors.white,
              valueIndicatorTextStyle: TextStyle(
                color: const Color(0xFF5C6579),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
              showValueIndicator: ShowValueIndicator.never,
              rangeThumbShape: CustomRangeThumbShape(
                enabledThumbRadius: 10,
                startValue: priceRange.start.round(),
                endValue: priceRange.end.round(),
              ),
              rangeTickMarkShape: const CustomNoRangeSliderTickMarkShape(),
            ),
            child: RangeSlider(
              values: priceRange,
              min: 4,
              max: 12,
              divisions: 8,
              labels: RangeLabels(
                priceRange.start.round().toString(),
                priceRange.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textGrey,
                ),
              ),
              Text(
                '12 years',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCityOptions() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Choose City dropdown (tap to expand/collapse list)
          GestureDetector(
            onTap: () {
              setState(() {
                _isCityExpanded = !_isCityExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGrey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedCity ?? 'Choose City',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: selectedCity != null
                          ? AppColors.textPrimaryBlack
                          : AppColors.textGrey,
                    ),
                  ),
                  Icon(
                    _isCityExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.textGrey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          // City list - only visible when expanded
          if (_isCityExpanded)
            Expanded(
              child: ListView.builder(
                itemCount: _cityOptions.length,
                itemBuilder: (context, index) {
                  final city = _cityOptions[index];
                  final isSelected = selectedCity == city;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        final wasSelected = isSelected;
                        selectedCity = wasSelected ? null : city;
                        // Optionally collapse after choosing
                        // _isCityExpanded = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            city,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.primaryOrange
                                  : AppColors.textPrimaryBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRatingOptions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _ratingOptions.length,
      itemBuilder: (context, index) {
        final option = _ratingOptions[index];
        final isSelected = selectedRatings.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedRatings.remove(option);
              } else {
                selectedRatings.add(option);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                SizedBox(width: 12),
                Text(
                  option,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.primaryOrange
                        : AppColors.textPrimaryBlack,
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

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double enabledThumbRadius;
  final int startValue;
  final int endValue;

  const CustomRangeThumbShape({
    this.enabledThumbRadius = 10.0,
    required this.startValue,
    required this.endValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(enabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb thumb = Thumb.start,
    bool isPressed = false,
  }) {
    final Canvas canvas = context.canvas;

    if (isPressed) {
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(center, enabledThumbRadius + 3, shadowPaint);
    }

    // 1. Outer white circle
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, enabledThumbRadius, borderPaint);

    // 2. Inner green filled circle
    final Paint fillPaint = Paint()
      ..color = const Color(0xFF168A40)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, enabledThumbRadius - 3.5, fillPaint);

    // 3. Draw the value indicator bubble (always visible!)
    final String valueText = thumb == Thumb.start ? '$startValue' : '$endValue';
    
    final TextPainter labelPainter = TextPainter(
      text: TextSpan(
        text: valueText,
        style: TextStyle(
          color: const Color(0xFF5C6579),
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    labelPainter.layout();

    final double boxWidth = labelPainter.width + 18;
    final double boxHeight = labelPainter.height + 10;
    const double verticalOffset = 30.0;

    final Offset tooltipCenter = center - const Offset(0, verticalOffset);

    final double left = tooltipCenter.dx - boxWidth / 2;
    final double right = tooltipCenter.dx + boxWidth / 2;
    final double top = tooltipCenter.dy - boxHeight / 2;
    final double bottom = tooltipCenter.dy + boxHeight / 2;
    const double radius = 4.0;
    const double arrowSize = 5.0;
    final double centerX = tooltipCenter.dx;

    final Path path = Path()
      ..moveTo(left + radius, top)
      ..lineTo(right - radius, top)
      ..quadraticBezierTo(right, top, right, top + radius)
      ..lineTo(right, bottom - radius)
      ..quadraticBezierTo(right, bottom, right - radius, bottom)
      ..lineTo(centerX + arrowSize, bottom)
      ..lineTo(centerX, bottom + arrowSize)
      ..lineTo(centerX - arrowSize, bottom)
      ..lineTo(left + radius, bottom)
      ..quadraticBezierTo(left, bottom, left, bottom - radius)
      ..lineTo(left, top + radius)
      ..quadraticBezierTo(left, top, left + radius, top)
      ..close();

    // Draw soft shadow
    final Paint tooltipShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, tooltipShadowPaint);

    // Draw white bubble fill
    final Paint tooltipFillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, tooltipFillPaint);

    // Draw thin light border
    final Paint tooltipBorderPaint = Paint()
      ..color = const Color(0xFFEEEEEE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(path, tooltipBorderPaint);

    // Paint centered label text
    final Offset textOffset = Offset(
      tooltipCenter.dx - labelPainter.width / 2,
      tooltipCenter.dy - labelPainter.height / 2,
    );
    labelPainter.paint(canvas, textOffset);
  }
}

class CustomNoRangeSliderTickMarkShape extends RangeSliderTickMarkShape {
  const CustomNoRangeSliderTickMarkShape();

  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
  }) {
    return Size.zero;
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool isEnabled = true,
    required TextDirection textDirection,
  }) {
    // Paints nothing to hide the ticks/dots on the track
  }
}

