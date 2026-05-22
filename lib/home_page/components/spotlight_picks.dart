import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/app_colors.dart';

class SpotlightPicks extends StatefulWidget {
  const SpotlightPicks({super.key});

  @override
  State<SpotlightPicks> createState() => _SpotlightPicksState();
}

class _SpotlightPicksState extends State<SpotlightPicks> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> spotlightItems = [
      {
        'title': 'Facebook Saloon',
        'location': 'Bypass road, Sangareddy 2.3km',
        'price': 'Starts From ₹299',
      },
      {
        'title': 'Facebook Saloon',
        'location': 'Bypass road, Sangareddy 2.3km',
        'price': 'Starts From ₹299',
      },
      {
        'title': 'Facebook Saloon',
    'location': 'Bypass road, Sangareddy 2.3km',
        'price': 'Starts From ₹299',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/icons/left_line.png',
              width: 15.w,
              height: 3.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
            Spacer(),
            Text(
              "Spotlight Picks",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/icons/right_line.png',
              width: 15.w,
              height: 3.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
          ],
        ),
        SizedBox(height: 2.h),
        CarouselSlider.builder(
          itemCount: spotlightItems.length,
            options: CarouselOptions(
              // height: 25.h,
              viewportFraction: 0.7,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              enableInfiniteScroll: true,
              padEnds: true,
              disableCenter: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
              final item = spotlightItems[index];
              final bool isActive = index == _current;
              return AnimatedScale(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                scale: isActive ? 1.0 : 0.85,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 0,
                    // right: index == spotlightItems.length - 1 ? 0 : 2.w,
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
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                      
                      
                        child: Stack(
                          children: [
                            ClipRRect(
                              // Clip only top corners for the image as well
                              borderRadius: BorderRadius.vertical(top: Radius.circular(2.w)),
                              child: Image.asset(
                                'assets/images/spoitlight_image.png',
                                width: double.infinity,
                                height: 17.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.grey200,
                                    child: Center(
                                      child: Icon(Icons.store, size: 6.w, color: AppColors.grey400),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,right: 3.w,top: 3.w,),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                       
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimaryBlack,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // SizedBox(width: 1.w),
                                Text(
                                  'Starts From',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondaryGrey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/location.png',
                                  width: 3.5.w,
                                  height: 3.5.w,
                                ),
                                SizedBox(width: 0.5.w),
                                Expanded(
                                  child: Text(
                                    item['location'],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColors.textSecondaryGrey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // SizedBox(width: 1.w),
                                Text(
                                  '₹299',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimaryBlack,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
