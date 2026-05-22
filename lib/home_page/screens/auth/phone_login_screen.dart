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
    } else if (value == '+*#') {
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
          builder: (context) => OTPVerificationScreen(phoneNumber: _phoneNumber),
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
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                  hintText: 'Enter your number',
                                  hintStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textGrey,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                enabled: false, // Disable keyboard, use keypad instead
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      // Terms and Privacy Policy text
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                          children: [
                            TextSpan(text: 'By tapping Continue, you are agreeing to our '),
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
                      SizedBox(height: 32),
                      // Continue button
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: _phoneNumber.length == 10 ? _onContinue : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryOrange,
                            disabledBackgroundColor: AppColors.borderGrey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            // Numeric Keypad
            Container(
              color: Color(0xFFF5F5F5),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Row 1: 1, 2, 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('1', ''),
                      _buildKeypadButton('2', 'ABC'),
                      _buildKeypadButton('3', 'DEF'),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Row 2: 4, 5, 6
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('4', 'GHI'),
                      _buildKeypadButton('5', 'JKL'),
                      _buildKeypadButton('6', 'MNO'),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Row 3: 7, 8, 9
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('7', 'PQRS'),
                      _buildKeypadButton('8', 'TUV'),
                      _buildKeypadButton('9', 'WXYZ'),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Row 4: +*#, 0, backspace
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildKeypadButton('+*#', ''),
                      _buildKeypadButton('0', ''),
                      _buildKeypadButton('backspace', '', isBackspace: true),
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

  Widget _buildKeypadButton(String value, String letters, {bool isBackspace = false}) {
    return GestureDetector(
      onTap: () => _onKeypadTap(value),
      child: Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: isBackspace
            ? Icon(Icons.backspace_outlined, color: AppColors.textBlack, size: 24)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
                  ),
                  if (letters.isNotEmpty)
                    Text(
                      letters,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGrey,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

