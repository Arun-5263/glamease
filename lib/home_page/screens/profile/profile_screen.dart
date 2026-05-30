import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/constants/app_strings.dart';
import 'package:glamease/home_page/screens/profile/my_profile_screen.dart';
import 'package:glamease/home_page/screens/profile/my_bookings_screen.dart';
import 'package:glamease/home_page/screens/profile/refer_earn_screen.dart';
import 'package:glamease/home_page/screens/profile/paw_coins_screen.dart';
import 'package:glamease/home_page/screens/profile/favourites_screen.dart';
import 'package:glamease/home_page/screens/profile/legal_info_screen.dart';
import 'package:glamease/home_page/screens/profile/support_screen.dart';
import 'package:glamease/home_page/screens/profile/student_employee_verification_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF9EECE),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundGrey,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with beige background covering status bar
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Color(0xFFF9EECE), // Header background
                    ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Background that extends to status bar
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/sunburst_pattern.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Content with SafeArea
                    SafeArea(
                      bottom: false,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              children: [
                                // Top row with back button and title
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back,
                                          color: AppColors.textPrimaryBlack),
                                      onPressed: () => Navigator.pop(context),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          AppStrings.profile,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimaryBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            40), // Balance space for back button
                                  ],
                                ),
                                SizedBox(height: 20),
                                // User Information Section inside header
                                Row(
                                  children: [
                                    // Profile Picture
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/icons/Profile_icon.png',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    // User Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Jennifer',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimaryBlack,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '+91 12345 67890',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textGrey,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'dummyprofile@gmail.com',
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
                                SizedBox(
                                    height: 6.h), // Space for overlapping card
                              ],
                            ),
                          ),
                          // Paw Coins Section - overlapping the header
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: -30, // Shifted down for overlap
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PawCoinsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundWhite,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.coins,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimaryBlack,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            AppStrings.availableBalance,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Golden coin icon
                                    Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/glam_coin.svg',
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36), // Space to account for overlapping card

              // Menu Items
              _buildMenuSection(
                context,
                [
                  _MenuItem(
                    iconPath: 'assets/icons/my_profile_icon.png',
                    title: AppStrings.myProfile,
                    subtitle: AppStrings.editProfile,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 8),

              _buildMenuSection(
                context,
                [
                  _MenuItem(
                    iconPath: 'assets/icons/my_profile_icon.png',
                    title: AppStrings.myBookings,
                    subtitle: AppStrings.upcomingPastBookings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBookingsScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    iconPath: 'assets/icons/Favourites_icon_profiler.svg',
                    title: AppStrings.favourites,
                    subtitle: AppStrings.yourSavedCenters,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouritesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              SizedBox(height: 8),

              _buildMenuSection(
                context,
                [
                  _MenuItem(
                    iconPath: 'assets/icons/student-card.svg',
                    title: 'Student/Employee',
                    subtitle: 'Verify your student/employee status',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StudentEmployeeVerificationScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    iconPath: 'assets/icons/my_profile_icon.png',
                    title: AppStrings.referAndEarn,
                    subtitle: AppStrings.inviteFriendsEarnRewards,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReferEarnScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    iconPath: 'assets/icons/legalinfo_icon.png',
                    title: AppStrings.legalInfo,
                    subtitle: AppStrings.termsPrivacyAndMore,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LegalInfoScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    iconPath: 'assets/icons/support_icon.png',
                    title: AppStrings.support,
                    subtitle: AppStrings.needHelpReachOut,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupportScreen(),
                        ),
                      );
                    },
                  ),
                  _MenuItem(
                    iconPath: 'assets/icons/sign-out.png',
                    title: AppStrings.logout,
                    subtitle: null,
                    onTap: () {
                      // Handle logout
                    },
                    isLogout: true,
                  ),
                ],
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, List<_MenuItem> items) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: items.map((item) {
            final isLogout = item.isLogout ?? false;
            return InkWell(
              onTap: item.onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    item.iconPath.endsWith('.svg')
                        ? SvgPicture.asset(
                            item.iconPath,
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            item.iconPath,
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: isLogout ? 16.sp : 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isLogout
                                  ? AppColors.textRed
                                  : AppColors.textPrimaryBlack,
                            ),
                          ),
                          if (item.subtitle != null) ...[
                            SizedBox(height: 2),
                            Text(
                              item.subtitle!,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textGrey,
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String iconPath;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool? isLogout;

  _MenuItem({
    required this.iconPath,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isLogout,
  });
}
