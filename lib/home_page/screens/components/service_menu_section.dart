import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class ServiceMenuSection extends StatefulWidget {
  final List<Map<String, dynamic>> serviceMenus;

  const ServiceMenuSection({
    Key? key,
    required this.serviceMenus,
  }) : super(key: key);

  @override
  State<ServiceMenuSection> createState() => _ServiceMenuSectionState();
}

class _ServiceMenuSectionState extends State<ServiceMenuSection> {
  int _currentMenuIndex = 0;

  void _showServiceMenuModal(BuildContext context, int initialIndex) {
    setState(() {
      _currentMenuIndex = initialIndex;
    });

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: Stack(
                    children: [
                      // Back button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 16,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset(
                            'assets/icons/back_icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      // Photo counter / numbers on top (centered in the middle, no text in middle)
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 24,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            '${_currentMenuIndex + 1}/${widget.serviceMenus.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // Main image
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              _currentMenuIndex =
                                  (_currentMenuIndex + 1) % widget.serviceMenus.length;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.6,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 120,
                              bottom: 120,
                            ),
                            child: Image.asset(
                              'assets/images/service_menue.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Thumbnail strip at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.serviceMenus.length,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              final isSelected = _currentMenuIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    _currentMenuIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                        : null,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/service_menue.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
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
      },
    );
  }

  void _showStyleGuideModal(BuildContext context, int initialIndex) {
    int currentStyleIndex = initialIndex;
    final List<String> styleGuides = [
      'assets/images/beard.png',
      'assets/images/hair_style.png',
      'assets/images/nail_arts.png',
      'assets/images/makeup.png',
    ];

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.2),
                  child: Stack(
                    children: [
                      // Back button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 16,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Image.asset(
                            'assets/icons/back_icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      // Photo counter / numbers on top (centered in the middle)
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 24,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            '${currentStyleIndex + 1}/${styleGuides.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // Main image
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              currentStyleIndex =
                                  (currentStyleIndex + 1) % styleGuides.length;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.6,
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 120,
                              bottom: 120,
                            ),
                            child: Image.asset(
                              styleGuides[currentStyleIndex],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Thumbnail strip at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: styleGuides.length,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              final isSelected = currentStyleIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    currentStyleIndex = index;
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                        : null,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      styleGuides[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
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
            itemCount: widget.serviceMenus.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showServiceMenuModal(context, index),
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
        SizedBox(height: 3.h),
        Text(
          'Style guide',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 3.w,
            childAspectRatio: 1,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final List<String> styleGuides = [
              'assets/images/beard.png',
              'assets/images/hair_style.png',
              'assets/images/nail_arts.png',
              'assets/images/makeup.png',
            ];
            final String styleGuideImage = styleGuides[index];
            return GestureDetector(
              onTap: () => _showStyleGuideModal(context, index),
              child: Container(
                decoration: BoxDecoration(),
                child: ClipRRect(
                  child: Image.asset(
                    styleGuideImage,
                    fit: BoxFit.cover,
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
