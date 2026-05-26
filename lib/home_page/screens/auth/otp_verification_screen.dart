import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import '../../../home_page/home_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  int _currentIndex = 0;
  int _resendTimer = 150; // 2 minutes 30 seconds in seconds
  Timer? _timer;
  String _maskedPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _maskPhoneNumber();
    _startResendTimer();
    // Auto-focus first field
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _maskPhoneNumber() {
    if (widget.phoneNumber.length >= 4) {
      String firstTwo = widget.phoneNumber.substring(0, 2);
      String lastTwo =
          widget.phoneNumber.substring(widget.phoneNumber.length - 2);
      _maskedPhoneNumber = '$firstTwo******$lastTwo';
    } else {
      _maskedPhoneNumber = widget.phoneNumber;
    }
  }

  void _startResendTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _onOTPChanged(String value, int index) {
    if (value.length == 1) {
      _otpControllers[index].text = value;
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
        _currentIndex = index + 1;
      }
    } else if (value.isEmpty) {
      _otpControllers[index].text = '';
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
        _currentIndex = index - 1;
      }
    }
  }

  void _onKeypadTap(String value) {
    if (value == 'backspace') {
      if (_currentIndex >= 0 &&
          _otpControllers[_currentIndex].text.isNotEmpty) {
        _otpControllers[_currentIndex].text = '';
        if (_currentIndex > 0) {
          _focusNodes[_currentIndex - 1].requestFocus();
          _currentIndex--;
        }
      } else if (_currentIndex > 0) {
        _focusNodes[_currentIndex - 1].requestFocus();
        _currentIndex--;
        _otpControllers[_currentIndex].text = '';
      }
    } else if (value == '+*#' || value == '+ * #') {
      // Handle special characters if needed
    } else {
      if (_currentIndex < 4) {
        _otpControllers[_currentIndex].text = value;
        if (_currentIndex < 3) {
          _focusNodes[_currentIndex + 1].requestFocus();
          _currentIndex++;
        }
      }
    }
    setState(() {});
  }

  void _onVerifyOTP() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      // Navigate to home screen after successful OTP verification
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PetSpaScreen()),
        (route) => false,
      );
    }
  }

  void _onResendOTP() {
    if (_resendTimer == 0) {
      setState(() {
        _resendTimer = 150;
      });
      _startResendTimer();
      // Resend OTP logic
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
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Navigation bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
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
                      SizedBox(height: 40),
                      // Title
                      Text(
                        'OTP Verification',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      // Instruction text
                      Text(
                        'We\'ve just sent an verification code to mobile number $_maskedPhoneNumber',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      // OTP input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _otpControllers[index].text.isNotEmpty
                                    ? AppColors.primaryOrange
                                    : AppColors.borderGrey,
                                width: 1.5,
                              ),
                            ),
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textBlack,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                _onOTPChanged(value, index);
                                setState(() {});
                              },
                              onTap: () {
                                _currentIndex = index;
                                setState(() {});
                              },
                              enabled:
                                  false, // Disable keyboard, use keypad instead
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Resend OTP and Verify OTP button, positioned statically above the keypad
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Column(
                children: [
                  // Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t recieve OTP? ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _resendTimer == 0 ? _onResendOTP : null,
                        child: Text(
                          'Resend (${_formatTimer(_resendTimer)})',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: _resendTimer == 0
                                ? AppColors.primaryOrange
                                : AppColors.textBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Verify OTP button
                  Container(
                    width: double.infinity,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange,
                      borderRadius: BorderRadius.circular(1.5.h),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        String otp = _otpControllers.map((c) => c.text).join();
                        if (otp.length == 4) {
                          _onVerifyOTP();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.5.h),
                        ),
                      ),
                      child: Text(
                        'Verify OTP',
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
              padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w, top: 1.h, bottom: 1.h),
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
