import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/app_colors.dart';
import 'components/header_section.dart';
import 'components/spotlight_picks.dart';
import 'components/curated_spa_center.dart';
import 'components/explore_section.dart';
import 'components/spa_centers_list.dart';
import 'screens/pay_bill/pay_bill_screen.dart';

class PetSpaScreen extends StatelessWidget {
  const PetSpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header section with teal-green background
            HeaderSection(),
            // Main content container with border radius - overlapping header
            Transform.translate(
              offset: const Offset(0, -14),
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 32,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(
              0xFFF3F6FA), // Match light blue-grey card background from image
          borderRadius:
              BorderRadius.circular(18), // Match rounded corners from image
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25), // #00000040
              blurRadius: 24,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tony & Guy',
                  style: TextStyle(
                    color: AppColors.textPrimaryBlack,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '10% OFF Applicable',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PayBillScreen(
                      venueName: 'Tony & Guy',
                      address: 'Madhapur, Hyderabad',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF7A1FA2), // Brand Purple from image
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      12), // Exact rounded corner from image
                ),
              ),
              child: Text(
                'Pay Bill',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),

        // Spotlight Picks - Full width carousel
        SpotlightPicks(),

        // Curated Spa Center - Full width with no horizontal padding
        const CuratedSpaCenter(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // Explore Pet Spa Centers
              ExploreSection(),

              const SizedBox(height: 16),

              // Spa center cards
              SpaCentersList(),
            ],
          ),
        ),
      ],
    );
  }
}
