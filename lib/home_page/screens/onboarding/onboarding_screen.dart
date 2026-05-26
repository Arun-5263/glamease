import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../auth/phone_login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      imagePath: 'assets/images/splash_1.png',
      title: 'Discover Nearby Salons & Stores',
      description:
          'Find the best beauty & saloons around you and book instantly.',
      buttonText: 'Next',
    ),
    OnboardingPage(
      imagePath: 'assets/images/splash_2.png',
      title: 'Reserve. Visit. Relax.',
      description:
          'Book your pet\'s spa or vet visit anytime and skip the queue – simple and stress-free.',
      buttonText: 'Next',
    ),
    OnboardingPage(
      imagePath: 'assets/images/splash_3.png',
      title: '💰 Pay Bills, Redeem Rewards',
      description:
          'Earn PawCoins and get exclusive discounts when you pay through PawTales.',
      buttonText: 'Get Started',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.jumpToPage(_currentPage + 1);
    } else {
      // Navigate to phone login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
      );
    }
  }

  void _skip() {
    // Navigate to phone login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhoneLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(), // Disable swipe gesture
              children: _pages.asMap().entries.map((entry) {
                return _buildPage(entry.value, entry.key);
              }).toList(),
            ),
            // Skip button
            Positioned(
              top: 0,
              right: 16,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
            ),
            // Back button (only show on pages 2 and 3)
            if (_currentPage > 0)
              Positioned(
                top: 0,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
                  onPressed: () {
                    _pageController.jumpToPage(_currentPage - 1);
                  },
                ),
              ),
            // Bottom decorative bar
            Positioned(
              bottom: 1.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 32.w,
                  height: 0.6.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(0.3.h),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              page.imagePath,
              fit: BoxFit.contain,
              width: 80.w,
            ),
          ),
        ),
        // Pagination indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _pages.length,
            (dotIndex) {
              if (dotIndex == index) {
                // Active indicator: horizontal rounded rectangle
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 32,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              } else {
                // Inactive indicator: circle
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.borderGrey,
                    shape: BoxShape.circle,
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: 24),
        // Title with emojis
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  page.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: Text(
            page.description,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGrey,
              fontFamily: 'Manrope',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40),
        // Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                page.buttonText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

class OnboardingPage {
  final String imagePath;
  final String title;

  final String description;
  final String buttonText;

  OnboardingPage({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}
