import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({Key? key}) : super(key: key);

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  final String referralCode = 'pawtales.app/refer?code=PAW1234';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Section with Sunburst Background and Content
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Sunburst Background extending to cover the Pet Illustration
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 10.h + 200, // Covers the pet illustration naturally
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/sunburst_pattern.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // The Main Content
                  Column(
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Column(
                          children: [
                            // Header
                            _buildHeader(),
                            SizedBox(height: 16),
                            // Title Section
                            _buildTitleSection(),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                      // Pet Illustrations and Referral Card
                      _buildPetIllustrationsWithCard(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Your Referrals Section
              _buildReferralsList(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryBlack),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Refer & Earn',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
            ),
          ),
          SizedBox(width: 40), // Balance space for back button
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Invite Friends. Earn Rewards.',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimaryBlack,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Get 150 Paw Coins for Every Signup!',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimaryBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildPetIllustration(String assetPath) {
    return Image.asset(
      assetPath,
      width: 50.w,
      height: 15.h,
      fit: BoxFit.contain,
    );
  }

  Widget _buildPetIllustrationsWithCard() {
    return SizedBox(
      height: 25.h + 245, // Height of image + approximate card height
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Referral Card positioned at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildReferralCard(),
          ),
          // Pet Illustration overlapping from above - bottom part over the card
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _buildPetIllustration('assets/images/Refer_earn.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Introductory Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimaryBlack,
                ),
                children: [
                  TextSpan(
                    text:
                        'Invite friends to Glamease and earn 150 Glamcoins when they join!.\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                  TextSpan(
                    text: 'See ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                  TextSpan(
                    text: 'How it works?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textFieldTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // Referral Link Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.referralInputBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    referralCode,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textFieldTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: referralCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Referral link copied!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.copy,
                      size: 15,
                      color: AppColors.textPrimaryBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Share Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle share action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Share',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          // Terms & Conditions
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle terms & conditions
              },
              child: Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Divider
          Container(
            height: 1,
            color: AppColors.borderGrey,
          ),
          SizedBox(height: 20),
          // Referral Summary
          _buildReferralSummary(),
        ],
      ),
    );
  }

  Widget _buildReferralSummary() {
    return Row(
      children: [
        // Left Column - Coins Earned
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '750',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Coins Earned',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
        // Vertical Divider
        Container(
          width: 1,
          height: 50,
          color: AppColors.borderGrey,
        ),
        // Right Column - Total Referrals
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '05',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Total Referrals',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReferralsList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Referrals',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 16),
          // Referral List Items
          ..._buildReferralItems(),
        ],
      ),
    );
  }

  List<Widget> _buildReferralItems() {
    final referrals = [
      {
        'name': 'Ramu',
        'date': '16 Jun, 09:31AM',
        'status': 'Joined',
        'coins': '+150 coins',
        'isJoined': true
      },
      {
        'name': 'Rajeshwari',
        'date': '16 Jun, 09:31AM',
        'status': 'Pending',
        'coins': '0 coins',
        'isJoined': false
      },
      {
        'name': 'Ramu',
        'date': '16 Jun, 09:31AM',
        'status': 'Joined',
        'coins': '+150 coins',
        'isJoined': true
      },
      {
        'name': 'Rajeshwari',
        'date': '16 Jun, 09:31AM',
        'status': 'Pending',
        'coins': '0 coins',
        'isJoined': false
      },
    ];

    return referrals.map((referral) {
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - Name and Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  referral['name'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimaryBlack,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  referral['date'] as String,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
            // Right side - Status and Coins
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Status : ${referral['status']}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: referral['isJoined'] as bool
                        ? AppColors.referralJoinedStatus
                        : AppColors.referralPendingStatus,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  referral['coins'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: referral['isJoined'] as bool
                        ? AppColors.referralJoinedStatus
                        : AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}
