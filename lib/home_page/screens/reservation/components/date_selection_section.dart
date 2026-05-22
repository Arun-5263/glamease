import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class DateSelectionSection extends StatelessWidget {
  final List<Map<String, dynamic>> dates;
  final int selectedDateIndex;
  final Function(int) onDateSelected;

  const DateSelectionSection({
    Key? key,
    required this.dates,
    required this.selectedDateIndex,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Date & Time',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final hasOffer = date['hasOffer'] ?? false;
                final isSelected = index == selectedDateIndex;
                
                return GestureDetector(
                  onTap: () => onDateSelected(index),
                    child: Card(
                      color: isSelected ? AppColors.textBlack : AppColors.backgroundWhite,
                      elevation: 0,
                      margin: EdgeInsets.only(right: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                    
                      ),
                      child: SizedBox(
                      width: 80,
                      height: 70,
                      child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                date['day'],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.backgroundWhite : AppColors.textBlack,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                date['date'],
                                style: TextStyle(
                                   fontSize: 10.sp,
                               fontWeight: FontWeight.w500,
                                  color: isSelected ? AppColors.backgroundWhite : AppColors.textBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (hasOffer)
                          Positioned(
                            bottom: -10,
                            left: 0,
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '10% OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                      ),
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
}
