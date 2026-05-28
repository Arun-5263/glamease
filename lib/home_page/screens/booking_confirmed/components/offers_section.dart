import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class OffersSection extends StatefulWidget {
  const OffersSection({super.key});

  @override
  State<OffersSection> createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/icons/left_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              Text(
                'Offers For You',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/right_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Carousel of 3 images
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            itemCount: 3,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/offers_for_u.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
