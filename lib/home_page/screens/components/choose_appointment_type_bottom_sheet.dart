import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class ChooseAppointmentTypeBottomSheet extends StatefulWidget {
  const ChooseAppointmentTypeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChooseAppointmentTypeBottomSheet> createState() =>
      _ChooseAppointmentTypeBottomSheetState();
}

class _ChooseAppointmentTypeBottomSheetState
    extends State<ChooseAppointmentTypeBottomSheet> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Center(
            child: Text(
              'Choose an option',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ),

          SizedBox(height: 24),

          // Option cards
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildOptionCard(
                    icon: Icons.person,
                    title: 'Book an appointment',
                    subtitle: 'Book an appointment only for yourself',
                    value: 'single',
                  ),
                  SizedBox(height: 16),
                  _buildOptionCard(
                    icon: Icons.people,
                    title: 'Group appointment',
                    subtitle: 'Book for 2 or more people',
                    value: 'group',
                  ),
                ],
              ),
            ),
          ),

          // Proceed button
          Container(
            padding: EdgeInsets.all(16),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedOption != null
                      ? () {
                          // Return a special marker for group to trigger second bottom sheet
                          Navigator.pop(context, _selectedOption);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B46C1), // Purple color
                    disabledBackgroundColor: AppColors.grey300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final isSelected = _selectedOption == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Color(0xFF6B46C1) // Purple border when selected
                : AppColors.grey300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.grey[700],
                size: 28,
              ),
            ),

            SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
