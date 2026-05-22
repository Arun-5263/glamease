import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/app_colors.dart';

class CuratedSpaCenter extends StatefulWidget {
  const CuratedSpaCenter({super.key});

  @override
  State<CuratedSpaCenter> createState() => _CuratedSpaCenterState();
}

class _CuratedSpaCenterState extends State<CuratedSpaCenter> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> comingSoonItems = [
      'assets/images/coming_soon.png',
      'assets/images/coming_soon.png',
      'assets/images/coming_soon.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/icons/left_line.png',
              width: 15.w,
              fit: BoxFit.contain,
            ),
            Spacer(),
            Text(
              "Curated Spa center for your Pet",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimaryBlack,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/icons/right_line.png',
              width: 15.w,
              fit: BoxFit.contain,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: CarouselSlider.builder(
            itemCount: comingSoonItems.length,
            options: CarouselOptions(
              height: 15.h,
              viewportFraction: 0.8,
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              padEnds: false,
              disableCenter: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final bool isActive = index == _current;
              return Container(
                margin: EdgeInsets.only(
                  left: 0,
                  right:  4.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    // BoxShadow(
                    //   color: AppColors.shadowVeryLight,
                    //   blurRadius: 24,
                    //   offset: Offset(0, 0),
                    // ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    comingSoonItems[index],
                    width: double.infinity,
                    height: 15.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 15.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF9B59B6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'COMING SOON',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
