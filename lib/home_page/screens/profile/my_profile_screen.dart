import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/constants/app_strings.dart';
import 'package:sizer/sizer.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: AppStrings.jennifer);
  final TextEditingController _mobileController = TextEditingController(text: AppStrings.mobileNumberValue);
  final TextEditingController _emailController = TextEditingController(text: AppStrings.emailIdValue);

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundGrey,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundGrey,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button and title
              Padding(
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
                          AppStrings.myProfile,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimaryBlack,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40), // Balance space for back button
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Profile Picture with Edit Button
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/icons/Profile_icon.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Edit button overlay
                  Positioned(
                    bottom: -15,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        // Handle edit profile picture
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xffE4F3FF),
                          shape: BoxShape.circle,
                         
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/edit_pencil.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),

              // Profile Details Card
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name Field
                          _buildTextField(
                            label: AppStrings.name,
                            controller: _nameController,
                          ),

                          SizedBox(height: 24),

                          // Mobile Number Field
                          _buildTextField(
                            label: AppStrings.mobileNumber,
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: 24),

                          // Email ID Field
                          _buildTextField(
                            label: AppStrings.emailId,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width:40.w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.saveButtonGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Handle save
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child: Text(
                          AppStrings.save,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryBlack,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.borderGrey,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryBlack,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

