import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../screens/spa_detail_screen.dart';

class SpaCenterCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String rating;
  final String discount;
  final Color discountColor;

  const SpaCenterCard({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.discount,
    required this.discountColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpaDetailScreen(
              title: title,
              location: location,
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
          borderRadius: BorderRadius.circular(15),
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
                // height: 150,
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
                      'assets/images/spa_center.png',
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
                      colors: [
                        Color(0xFF4CAF50),
                        Color(0xFF204921).withValues(alpha: 0.0),
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
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
                        location,
                        style: TextStyle(
                          fontSize: 10.sp,fontWeight: FontWeight.w400,
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
                            fontSize: 10.sp,fontWeight: FontWeight.w400,
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
