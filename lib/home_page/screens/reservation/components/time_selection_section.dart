import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TimeSelectionSection extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const TimeSelectionSection({
    Key? key,
    required this.timeSlots,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What time works?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color:AppColors.textBlack,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final time = timeSlots[index];
              final isSelected = selectedTime == time;
              
              return GestureDetector(
                onTap: () => onTimeSelected(time),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.textBlack : AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(12),
                 
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.backgroundWhite : AppColors.textBlack,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
