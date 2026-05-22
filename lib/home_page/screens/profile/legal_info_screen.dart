import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';
import 'refund_cancellation_screen.dart';

class LegalInfoScreen extends StatelessWidget {
  const LegalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
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
          'Legal & Info',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/terms&conditions.svg',
                title: 'Terms & Conditions',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsConditionsScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/images/privacy_policy.svg',
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/refund&cancellation.svg',
                title: 'Refund & Cancellation Policy',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RefundCancellationScreen(),
                    ),
                  );
                },
              ),
              _buildMenuItem(
                context,
                iconPath: null,
                title: 'Delete Account',
                isDelete: true,
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    String? iconPath,
    required String title,
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            if (iconPath != null)
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  isDelete ? AppColors.textRed : AppColors.textBlack,
                  BlendMode.srcIn,
                ),
              )
            else
              Icon(
                Icons.delete_outline,
                size: 24,
                color: AppColors.textRed,
              ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDelete ? AppColors.textRed : AppColors.textBlack,
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle Bar
              Container(
                width: 60,
                height: 4,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.textBlack,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Delete Account Image
              Image.asset(
                'assets/images/delete_acc_image.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.pets, size: 60, color: Colors.brown);
                },
              ),
              SizedBox(height: 24),
              // Heading
              Text(
                'This makes us a little sad...',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Message
              Text(
                'Deleting your account removes all your data permanently. Do you still want to continue?',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle delete account
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.textRed, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textRed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundGrey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Keep My Account',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        );
      },
    );
  }
}

