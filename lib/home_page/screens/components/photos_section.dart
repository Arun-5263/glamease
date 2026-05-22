import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class PhotosSection extends StatefulWidget {
  final List<String> photoUrls;
  final VoidCallback onSeeAll;

  const PhotosSection({
    Key? key,
    required this.photoUrls,
    required this.onSeeAll,
  }) : super(key: key);

  @override
  State<PhotosSection> createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'Ambience', 'Services'];
  int _currentPhotoIndex = 0;

  void _showPhotoGallery(BuildContext context, int initialIndex) {
    setState(() {
      _currentPhotoIndex = initialIndex;
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
                  color: Colors.transparent,
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
                    // Photo counter
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 16,
                      right: 16,
                      child: Text(
                        '${_currentPhotoIndex + 1}/${widget.photoUrls.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Category filters
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 70,
                      left: 16,
                      right: 50,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A3A), // Dark gray background
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _categories.asMap().entries.map((entry) {
                            final index = entry.key;
                            final category = entry.value;
                            final isSelected = _selectedCategoryIndex == index;
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                  },
                                  child: isSelected
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5E6D3), // Light yellow/cream
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            category,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            category,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                ),
                                if (index < _categories.length - 1)
                                  SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    // Main image
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setModalState(() {
                            _currentPhotoIndex =
                                (_currentPhotoIndex + 1) % widget.photoUrls.length;
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
                            widget.photoUrls[_currentPhotoIndex],
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.grey300,
                                child: Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: AppColors.grey500,
                                  ),
                                ),
                              );
                            },
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
                          itemCount: widget.photoUrls.length,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            final isSelected = _currentPhotoIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  _currentPhotoIndex = index;
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
                                    widget.photoUrls[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.grey300,
                                        child: Icon(
                                          Icons.image,
                                          color: AppColors.grey500,
                                        ),
                                      );
                                    },
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
          'Photos',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        GestureDetector(
          onTap: () => _showPhotoGallery(context, 0),
          child: Container(
            height: 20.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.photoUrls.isNotEmpty
                  ? Image.asset(
                      widget.photoUrls[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey300,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 40.sp,
                              color: AppColors.grey500,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: AppColors.grey300,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: 40.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        SizedBox(
          height: 8.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.photoUrls.length + 1, // +1 for "See All" button
            itemBuilder: (context, index) {
              if (index == widget.photoUrls.length) {
                // "See All" button
                return GestureDetector(
                  onTap: widget.onSeeAll,
                  child: Container(
                    width: 8.h,
                    height: 8.h,
                    margin: EdgeInsets.only(right: 2.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return GestureDetector(
                onTap: () => _showPhotoGallery(context, index),
                child: Container(
                  width: 8.h,
                  height: 8.h,
                  margin: EdgeInsets.only(right: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.photoUrls[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey300,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 20.sp,
                              color: AppColors.grey500,
                            ),
                          ),
                        );
                      },
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
