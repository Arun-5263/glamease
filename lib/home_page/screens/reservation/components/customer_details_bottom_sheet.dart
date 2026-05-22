import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomerDetailsBottomSheet extends StatefulWidget {
  final VoidCallback onContinue;
  final String? title;
  final String? subtitle;
  final String? buttonText;

  const CustomerDetailsBottomSheet({
    Key? key,
    required this.onContinue,
    this.title,
    this.subtitle,
    this.buttonText,
  }) : super(key: key);

  @override
  State<CustomerDetailsBottomSheet> createState() =>
      _CustomerDetailsBottomSheetState();
}

class _CustomerDetailsBottomSheetState
    extends State<CustomerDetailsBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(6.w, 1.5.h, 6.w, 4.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 20.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 2.5.h),

          // Title
          Text(
            widget.title ?? 'Enter your details to proceed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 1.h),

          // Subtitle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              widget.subtitle ??
                  "We'll use this to confirm your reservation and send updates",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Name Field
          Text(
            'Name',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 1.h),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              hintStyle: TextStyle(
                  color: AppColors.textFieldTextColor, fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF1F1F1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF1F1F1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF7A1FA2)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),
          SizedBox(height: 2.h),

          // Email Field
          Text(
            'Email',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 1.h),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email address',
              hintStyle: TextStyle(
                  color: AppColors.textFieldTextColor, fontSize: 14.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF1F1F1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFF1F1F1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF7A1FA2)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            ),
          ),
          SizedBox(height: 4.h),

          // Continue Button
          SizedBox(
            height: 6.h,
            child: ElevatedButton(
              onPressed: () {
                // Here we would typically validate inputs before proceeding
                widget.onContinue();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7A1FA2), // Purple color from image
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                widget.buttonText ?? 'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
