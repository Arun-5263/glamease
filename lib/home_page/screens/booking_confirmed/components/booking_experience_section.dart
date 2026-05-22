import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../transaction_successful/components/feedback_bottom_sheet.dart';

class BookingExperienceSection extends StatefulWidget {
  @override
  _BookingExperienceSectionState createState() => _BookingExperienceSectionState();
}

class _BookingExperienceSectionState extends State<BookingExperienceSection> {
  int selectedRating = 3; // Default to "Good" (index 3)

  final List<Map<String, dynamic>> ratings = [
    {'unselected': 'assets/icons/terrible_unselected.svg', 'selected': 'assets/icons/terrible.svg', 'label': 'Terrible'},
    {'unselected': 'assets/icons/bad_unselected.svg', 'selected': 'assets/icons/bad.svg', 'label': 'Bad'},
    {'unselected': 'assets/icons/okay_unselected.svg', 'selected': 'assets/icons/okay.svg', 'label': 'Okay'},
    {'unselected': 'assets/icons/good_unselected.svg', 'selected': 'assets/icons/good.svg', 'label': 'Good'},
    {'unselected': 'assets/icons/great_unselected.svg', 'selected': 'assets/icons/great.svg', 'label': 'Great'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFFFF9E9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOpacity10,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How was your booking experience?',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ratings.asMap().entries.map((entry) {
                final index = entry.key;
                final rating = entry.value;
                final isSelected = index == selectedRating;
                
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // Show bottom sheet only for Terrible and Good
                      final label = rating['label'] as String;
                      if (label == 'Terrible') {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FeedbackBottomSheet(selectedRating: 'Bad'),
                        );
                      } else if (label == 'Good') {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => FeedbackBottomSheet(selectedRating: 'Good'),
                        );
                      }
                      // Bad, Okay, and Great don't show bottom sheet
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            isSelected ? rating['selected'] : rating['unselected'],
                            width: 35,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          rating['label'],
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textGrey,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

