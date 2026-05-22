import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/home_page/components/filter_bottom_sheet.dart';
import 'package:glamease/home_page/screens/components/review_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AllReviewsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  final double averageRating;
  final int totalReviews;
  final Map<int, int>? ratingBreakdown;

  const AllReviewsScreen({
    super.key,
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
    this.ratingBreakdown,
  });

  @override
  State<AllReviewsScreen> createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {
  final Set<int> _selectedStars = {};
  String _selectedSort = 'Newest';
  late Map<int, int> _ratingCounts;

  @override
  void initState() {
    super.initState();
    _ratingCounts = widget.ratingBreakdown ?? _calculateRatingCounts();
  }

  Map<int, int> _calculateRatingCounts() {
    final Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final review in widget.reviews) {
      final rating = review['rating'] is int
          ? review['rating'] as int
          : (review['rating'] as double).round();
      if (counts.containsKey(rating)) {
        counts[rating] = counts[rating]! + 1;
      }
    }
    return counts;
  }

  List<Map<String, dynamic>> get _filteredReviews {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      widget.reviews,
    );

    if (_selectedStars.isNotEmpty) {
      data = data
          .where(
            (review) => _selectedStars.contains(
              (review['rating'] as double).round(),
            ),
          )
          .toList();
    }

    switch (_selectedSort) {
      case 'Highest rating':
        data.sort((a, b) => (b['rating'] as double)
            .compareTo(a['rating'] as double));
        break;
      case 'Lowest rating':
        data.sort((a, b) => (a['rating'] as double)
            .compareTo(b['rating'] as double));
        break;
      case 'Newest':
      default:
        break;
    }
    return data;
  }

  void _toggleStar(int star) {
    setState(() {
      if (_selectedStars.contains(star)) {
        _selectedStars.remove(star);
      } else {
        _selectedStars.add(star);
      }
    });
  }

  Future<void> _openFilters() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(),
    );
  }

  double _progressFor(int star) {
    final maxCount = _ratingCounts.values.fold<int>(
      0,
      (previousValue, element) => max(previousValue, element),
    );
    if (maxCount == 0) return 0;
    return _ratingCounts[star]! / maxCount;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.backgroundWhite,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: Column(
          children: [
            // Header section with white background card - extends behind status bar
            Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 20,
                      ),
                      SizedBox(height: 1.5.h),
                      _buildSummaryCard(),
                    ],
                  ),
                ),
              ),
            ),
            // Content section with gray background
            Expanded(
              child: Container(
                color: AppColors.backgroundGrey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterRow(),
                        SizedBox(height: 1.h),
                        _buildHeaderRow(),
                        SizedBox(height: 1.5.h),
                        _buildReviewsList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  final star = 5 - index;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.5.h),
                    child: Row(
                      children: [
                        Text(
                          '$star',
                          style: GoogleFonts.mulish(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack,
                          ),
                        ),
                        SizedBox(width: 0.5.w),
                        Icon(
                          Icons.star,
                          color: const Color(0xFFE4A70A),
                          size: 14,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: _progressFor(star),
                              minHeight: 6,
                              backgroundColor: AppColors.grey200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF2D8659), // Dark green color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 4.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.averageRating.toStringAsFixed(1),
                  style: GoogleFonts.mulish(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 0.8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Icon(
                        index < widget.averageRating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: index < widget.averageRating.round()
                            ? const Color(0xFFE4A70A)
                            : AppColors.grey300,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0.8.h),
                Text(
                  '${widget.totalReviews} Reviews',
                  style: GoogleFonts.mulish(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: _openFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune,
                    size: 18,
                    color: AppColors.textBlack,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          ...List.generate(4, (index) {
            final star = 5 - index;
            return Padding(
              padding: EdgeInsets.only(right: 8),
              child: _ratingChip(star),
            );
          }),
        ],
      ),
    );
  }

  Widget _ratingChip(int star) {
    final bool isSelected = _selectedStars.contains(star);
    return GestureDetector(
      onTap: () => _toggleStar(star),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: isSelected ? AppColors.primaryGold : AppColors.grey300,
          //   width: isSelected ? 1.5 : 1,
          // ),
       
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$star',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(width: 3),
            Icon(
              Icons.star,
              size: 16,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${_filteredReviews.length} Reviews',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        _sortDropdown(),
      ],
    );
  }

  Widget _sortDropdown() {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      onSelected: (value) {
        setState(() {
          _selectedSort = value;
        });
      },
      itemBuilder: (context) => [
        'Newest',
        'Oldest',
        'Highest rating',
        'Lowest rating',
      ]
          .map(
            (option) => PopupMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          )
          .toList(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _selectedSort,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(width: 0.4.w),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.textBlack,
              size: 3.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return Column(
      children: _filteredReviews
          .map(
            (review) => Padding(
              padding: EdgeInsets.only(bottom: 1.5.h),
              child: ReviewCard(
                reviewerName: review['name'],
                rating: review['rating'],
                reviewText: review['text'],
                timeAgo: review['timeAgo'],
                profileImageUrl: review['profileImageUrl'],
              ),
            ),
          )
          .toList(),
    );
  }
}



