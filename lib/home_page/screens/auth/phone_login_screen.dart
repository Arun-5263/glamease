import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'otp_verification_screen.dart';
import '../../home_screen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _phoneNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onKeypadTap(String value) {
    if (value == 'backspace') {
      if (_phoneNumber.isNotEmpty) {
        setState(() {
          _phoneNumber = _phoneNumber.substring(0, _phoneNumber.length - 1);
          _phoneController.text = _phoneNumber;
        });
      }
    } else if (value == '+*#' || value == '+ * #') {
      // Handle special characters if needed
    } else {
      if (_phoneNumber.length < 10) {
        setState(() {
          _phoneNumber += value;
          _phoneController.text = _phoneNumber;
        });
      }
    }
  }

  void _onContinue() {
    if (_phoneNumber.length == 10) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OTPVerificationScreen(phoneNumber: _phoneNumber),
        ),
      );
    }
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
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Navigation bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to home screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => PetSpaScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      // Title
                      Text(
                        'What\'s your number?',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      // Phone input field
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '+91',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlack,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textBlack,
                                ),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textGrey,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                enabled:
                                    false, // Disable keyboard, use keypad instead
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Terms & Privacy Policy and Continue button, positioned statically above the keypad
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                        children: [
                          TextSpan(
                              text:
                                  'By tapping Continue, you are agreeing to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    width: double.infinity,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(1.5.h),
                    ),
                    child: ElevatedButton(
                      onPressed: _phoneNumber.length == 10 ? _onContinue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        disabledBackgroundColor: AppColors.borderGrey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.5.h),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Numeric Keypad
            Container(
              color: Color(0xFFCFD3D9),
              padding: EdgeInsets.only(
                  left: 1.5.w, right: 1.5.w, top: 1.h, bottom: 1.h),
              child: Column(
                children: [
                  // Row 1: 1, 2, 3
                  Row(
                    children: [
                      _buildKeypadButton('1', ''),
                      _buildKeypadButton('2', 'ABC'),
                      _buildKeypadButton('3', 'DEF'),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  // Row 2: 4, 5, 6
                  Row(
                    children: [
                      _buildKeypadButton('4', 'GHI'),
                      _buildKeypadButton('5', 'JKL'),
                      _buildKeypadButton('6', 'MNO'),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  // Row 3: 7, 8, 9
                  Row(
                    children: [
                      _buildKeypadButton('7', 'PQRS'),
                      _buildKeypadButton('8', 'TUV'),
                      _buildKeypadButton('9', 'WXYZ'),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  // Row 4: + * #, 0, backspace
                  Row(
                    children: [
                      _buildKeypadButton('+ * #', '', isSpecial: true),
                      _buildKeypadButton('0', ''),
                      _buildKeypadButton('backspace', '', isBackspace: true),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom decorative bar inside the keyboard area to match background color
            Container(
              color: Color(0xFFCFD3D9),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 1.5.h,
                top: 6.h,
              ),
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

  Widget _buildKeypadButton(String value, String letters,
      {bool isBackspace = false, bool isSpecial = false}) {
    final bool isTransparent = isBackspace || isSpecial;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeypadTap(value),
        child: Container(
          height: 5.8.h,
          margin: EdgeInsets.symmetric(horizontal: 0.8.w),
          decoration: isTransparent
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0.6.h),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      offset: Offset(0, 0.1.h),
                      blurRadius: 0.1.h,
                    ),
                  ],
                ),
          child: isBackspace
              ? Center(
                  child: Icon(
                    Icons.backspace_outlined,
                    color: AppColors.textBlack,
                    size: 22,
                  ),
                )
              : isSpecial
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '+',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textBlack,
                            ),
                          ),
                          SizedBox(width: 8),
                          Transform.translate(
                            offset: Offset(0, 3.5),
                            child: Text(
                              '*',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '#',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack,
                            height: 1.1,
                          ),
                        ),
                        if (letters.isNotEmpty)
                          Text(
                            letters,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                              letterSpacing: 2.0,
                              height: 0.9,
                            ),
                          ),
                      ],
                    ),
        ),
      ),
    );
  }
}
