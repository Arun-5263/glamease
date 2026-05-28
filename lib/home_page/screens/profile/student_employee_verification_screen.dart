import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class StudentEmployeeVerificationScreen extends StatefulWidget {
  const StudentEmployeeVerificationScreen({Key? key}) : super(key: key);

  @override
  State<StudentEmployeeVerificationScreen> createState() =>
      _StudentEmployeeVerificationScreenState();
}

class _StudentEmployeeVerificationScreenState
    extends State<StudentEmployeeVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isValidEmail = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateEmail(String value) {
    // Simple email validation matching standard formats
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    setState(() {
      _isValidEmail = emailRegex.hasMatch(value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Verify as Student/Employee',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Banner Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/verify_student_banner.png',
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF59E0B),
                          Color(0xFFEA580C),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'Unlock Special Pricing',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Email Input and Info Card
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text input container
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isFocused
                            ? const Color(0xFF7A1FA2)
                            : const Color(0xFFE5E7EB),
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: _emailController,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Enter your college/office email',
                        hintStyle: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Verify with your college/work email to unlock exclusive savings. OTP will be sent for confirmation.',
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isValidEmail
                  ? () {
                      // Navigate or trigger OTP Verification action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP sent to your email successfully!'),
                          backgroundColor: Color(0xFF7A1FA2),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF7A1FA2), // Brand Purple Enabled Color
                disabledBackgroundColor:
                    const Color(0xFFCCCCCC), // Grey Disabled Color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
