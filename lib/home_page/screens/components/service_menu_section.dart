import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class ServiceMenuSection extends StatelessWidget {
  final List<Map<String, dynamic>> serviceMenus;

  const ServiceMenuSection({
    Key? key,
    required this.serviceMenus,
  }) : super(key: key);

  void _showServiceMenuModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Stack(
                children: [
                  // Service menu image
                  Center(
                    child: SingleChildScrollView(
                      child: Image.asset(
                        'assets/images/service_menue.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Close button
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset(
                        'assets/icons/close_icon.png',
                        width: 42,
                        height: 42,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Menu',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 14.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: serviceMenus.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showServiceMenuModal(context),
                child: Container(
                  width: 25.w,
                  height: 14.h,
                  margin: EdgeInsets.only(right: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/service_menue.png',
                      width: 25.w,
                      height: 14.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
