import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../spa_detail_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
          backgroundColor: AppColors.backgroundGrey,
      
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Favourites',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFavouriteCard(
              context,
              imagePath: 'assets/images/spa_center.png',
              title: 'Peek a Bow-The pet club',
              location: 'Lingampalli, BHEL...',
              distance: '2.3km',
              price: '₹900',
              rating: '4.9 (1,092 Reviews)',
              discount: 'Flat 40% OFF On First Booking',
              discountColor: Colors.green,
            ),
            SizedBox(height: 16),
            _buildFavouriteCard(
              context,
              imagePath: 'assets/images/spa_center.png',
              title: 'Peek a Bow-The pet club',
              location: 'Lingampalli, BHEL...',
              distance: '2.3km',
              price: '₹900',
              rating: '4.9 (1,092 Reviews)',
              discount: 'Flat 35% OFF On First Booking',
              discountColor: Colors.green,
            ),
            SizedBox(height: 16),
            _buildFavouriteCard(
              context,
              imagePath: 'assets/images/spa_center.png',
              title: 'Marshal pet spa',
              location: 'Kukatpally, Rd-5',
              distance: '4.3km',
              price: '₹1200',
              rating: '4.9 (1,092 Reviews)',
              discount: 'Flat 10% OFF On First Booking',
              discountColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavouriteCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String location,
    required String distance,
    required String price,
    required String rating,
    required String discount,
    required Color discountColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpaDetailScreen(
              title: title,
              location: '$location • $distance',
              price: price,
              rating: rating,
              address: '1st Floor, Lingampally Road, Opp BHEL, Hyderabad',
              hours: 'Open until 8:00 pm',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    color: AppColors.textWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.store, size: 50, color: Colors.grey[400]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Favorite Heart Icon
                Positioned(
                  top: 16,
                  right: 16,
                  child: Image.asset(
                    'assets/icons/fav_icon.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
                // Discount Banner
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: discountColor == Colors.orange
                            ? [
                                Color(0xFFFFB300),
                                Color(0xFFFFB300).withOpacity(0.0),
                              ]
                            : [
                                Color(0xFF4CAF50),
                                Color(0xFF204921).withOpacity(0.0),
                              ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      discount,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Starts From ',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryGrey,
                            ),
                          ),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimaryBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
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
                          '$location • $distance',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondaryGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            rating,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

