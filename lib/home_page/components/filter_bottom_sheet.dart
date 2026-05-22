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
              activeTrackColor: AppColors.primaryTeal,
              inactiveTrackColor:
                  AppColors.primaryTeal.withValues(alpha: 0.2),
              // Solid white thumbs with no colored halo
              thumbColor: Colors.white,
              overlayColor: Colors.transparent,
              // White value indicator boxes above thumbs with dark text
              valueIndicatorColor: const Color.fromARGB(255, 249, 244, 244),
              valueIndicatorTextStyle: TextStyle(
                color: AppColors.textBlack,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              showValueIndicator: ShowValueIndicator.always,
              rangeThumbShape:
                  const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: RangeSlider(
              values: priceRange,
              min: 0,
              max: 12,
              divisions: 12,
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
                priceRange.start.round().toString(),
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

