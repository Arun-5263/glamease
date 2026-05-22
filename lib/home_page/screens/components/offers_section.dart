import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class OffersSection extends StatelessWidget {
  final List<String> offers;

  const OffersSection({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offers',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 12.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Container(
                width: 36.w,
                margin: EdgeInsets.only(right: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    // BoxShadow(
                    //   color: AppColors.shadowBlack,
                    //   blurRadius: 4,
                    //   offset: Offset(0, 2),
                    // ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    // Background image - reflect.png (smaller size)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(14),
                        ),
                        child: Image.asset(
                          'assets/icons/reflect.png',
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.6.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upto',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textBlack,
                                ),
                              ),
                              Text(
                                offers[index],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textBlack,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'assets/icons/E-commerce.png',
                              width: 3.5.w,
                              height: 3.5.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
