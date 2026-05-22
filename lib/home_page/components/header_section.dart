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
                          Icon(Icons.location_on,
                              color: AppColors.textBlack, size: 2.5.h),
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
                      SvgPicture.string(headerPointsSvg, height: 3.5.h),
                      // Notifications and profile
                      Row(
                        children: [
                          Stack(
                            children: [
                              Icon(Icons.notifications_none,
                                  color: AppColors.textBlack, size: 3.h),
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

const String headerPointsSvg =
    '''<svg width="57" height="28" viewBox="0 0 57 28" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="57" height="28" rx="14" fill="#FFF3E2"/>
<g clip-path="url(#clip0_4137_8112)">
<path d="M14 26C20.6274 26 26 20.6274 26 14C26 7.37258 20.6274 2 14 2C7.37258 2 2 7.37258 2 14C2 20.6274 7.37258 26 14 26Z" fill="#7A1FA2"/>
<path d="M19.0775 12.4629H22.73L23 10.9629H19.4675C18.7711 10.9846 18.0961 11.2087 17.525 11.6079C17.315 10.8579 15.275 10.9629 15.275 10.9629L15.545 9.46289H14.75L14.48 10.9629H13.6475L13.88 9.46289H13.0175L12.7025 10.9629H11.81L11.3525 13.3029L10.745 11.0079H8.75L5 16.5204H8.09L8.405 15.0579H7.775L9.575 12.4254L10.25 15.0729H9.575L9.2825 16.5204H11.5775L11.39 17.5254H12.29L12.5 16.5204H13.25L13.0625 17.5254H14L14.1875 16.5204H15.3575C15.8955 16.4594 16.3935 16.2064 16.76 15.8079C17.197 16.2501 17.7885 16.5056 18.41 16.5204H21.9425L22.175 15.0579H19.0025C16.82 15.0204 17.75 12.4479 19.0775 12.4629ZM15.11 15.0204H12.77L12.9575 14.3079H15.2075C15.7775 14.3454 15.59 15.0204 15.11 15.0204ZM15.4625 13.1004H13.1225L13.31 12.3879H15.56C16.13 12.4254 15.92 13.1304 15.4625 13.1304V13.1004Z" fill="white"/>
</g>
<path d="M33.428 19V17.572H29.6V16.222L32.366 10.36H34.016L31.25 16.222H33.428V13.972H34.892V16.222H35.702V17.572H34.892V19H33.428ZM40.2488 19.18C39.6368 19.18 39.0968 19.05 38.6288 18.79C38.1608 18.526 37.7948 18.16 37.5308 17.692C37.2708 17.224 37.1408 16.684 37.1408 16.072V13.288C37.1408 12.676 37.2708 12.136 37.5308 11.668C37.7948 11.2 38.1608 10.836 38.6288 10.576C39.0968 10.312 39.6368 10.18 40.2488 10.18C40.8608 10.18 41.3988 10.312 41.8628 10.576C42.3308 10.836 42.6968 11.2 42.9608 11.668C43.2248 12.136 43.3568 12.676 43.3568 13.288V16.072C43.3568 16.684 43.2248 17.224 42.9608 17.692C42.6968 18.16 42.3308 18.526 41.8628 18.79C41.3988 19.05 40.8608 19.18 40.2488 19.18ZM40.2488 17.806C40.5528 17.806 40.8288 17.734 41.0768 17.59C41.3248 17.442 41.5208 17.246 41.6648 17.002C41.8088 16.754 41.8808 16.478 41.8808 16.174V13.18C41.8808 12.872 41.8088 12.596 41.6648 12.352C41.5208 12.104 41.3248 11.908 41.0768 11.764C40.8288 11.616 40.5528 11.542 40.2488 11.542C39.9448 11.542 39.6688 11.616 39.4208 11.764C39.1728 11.908 38.9768 12.104 38.8328 12.352C38.6888 12.596 38.6168 12.872 38.6168 13.18V16.174C38.6168 16.478 38.6888 16.754 38.8328 17.002C38.9768 17.246 39.1728 17.442 39.4208 17.59C39.6688 17.734 39.9448 17.806 40.2488 17.806ZM48.1472 19.18C47.5352 19.18 46.9952 19.05 46.5272 18.79C46.0592 18.526 45.6932 18.16 45.4292 17.692C45.1692 17.224 45.0392 16.684 45.0392 16.072V13.288C45.0392 12.676 45.1692 12.136 45.4292 11.668C45.6932 11.2 46.0592 10.836 46.5272 10.576C46.9952 10.312 47.5352 10.18 48.1472 10.18C48.7592 10.18 49.2972 10.312 49.7612 10.576C50.2292 10.836 50.5952 11.2 50.8592 11.668C51.1232 12.136 51.2552 12.676 51.2552 13.288V16.072C51.2552 16.684 51.1232 17.224 50.8592 17.692C50.5952 18.16 50.2292 18.526 49.7612 18.79C49.2972 19.05 48.7592 19.18 48.1472 19.18ZM48.1472 17.806C48.4512 17.806 48.7272 17.734 48.9752 17.59C49.2232 17.442 49.4192 17.246 49.5632 17.002C49.7072 16.754 49.7792 16.478 49.7792 16.174V13.18C49.7792 12.872 49.7072 12.596 49.5632 12.352C49.4192 12.104 49.2232 11.908 48.9752 11.764C48.7272 11.616 48.4512 11.542 48.1472 11.542C47.8432 11.542 47.5672 11.616 47.3192 11.764C47.0712 11.908 46.8752 12.104 46.7312 12.352C46.5872 12.596 46.5152 12.872 46.5152 13.18V16.174C46.5152 16.478 46.5872 16.754 46.7312 17.002C46.8752 17.246 47.0712 17.442 47.3192 17.59C47.5672 17.734 47.8432 17.806 48.1472 17.806Z" fill="black"/>
<defs>
<clipPath id="clip0_4137_8112">
<rect width="24" height="24" fill="white" transform="translate(2 2)"/>
</clipPath>
</defs>
</svg>''';
