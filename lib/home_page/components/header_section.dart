import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/app_colors.dart';
import '../screens/profile/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderSection extends StatefulWidget {
  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final List<String> banners = [
    'assets/images/lakme_banner.png',
    'assets/images/lakme_banner.png',
    'assets/images/lakme_banner.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: AppColors.primaryGradient,
      //   ),
      // ),
      child: Stack(
        children: [
          // Sunburst pattern background for entire header
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sunburst_pattern.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row with location and notifications
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Location section
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/location.png',
                            height: 2.5.h,
                            width: 2.5.h,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 2.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hyderabad',
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Madhapur, ayyapa socie...',
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/header_points.svg',
                            height: 3.5.h,
                          ),
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '1200',
                                  style: TextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Notifications and profile
                      Row(
                        children: [
                          Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/notification.svg',
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 2.w,
                                  height: 2.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.textRed,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 2.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 2.5.h,
                              backgroundColor: AppColors.backgroundWhite,
                              child: Icon(Icons.person, size: 2.5.h),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                // Carousel slider for banners
                Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: banners.length,
                      options: CarouselOptions(
                        height: 18.h,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          height: 18.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              banners[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 18.h,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: ${banners[index]}');
                                print('Error: $error');
                                return Container(
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image,
                                            size: 6.w,
                                            color: AppColors.grey400),
                                        SizedBox(height: 1.h),
                                        Text(
                                          'Image not found',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: AppColors.grey400,
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
                    SizedBox(height: 0.5.h),
                  ],
                ),
                SizedBox(
                  height: 1.5.h,
                ),

                // Search bar
                Container(
                  margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search saloon/spa',
                      hintStyle: TextStyle(
                          color: AppColors.grey600,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                      suffixIcon: Icon(Icons.search, size: 3.h),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 2.5.h),
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
}
