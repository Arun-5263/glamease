import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class RefundCancellationScreen extends StatelessWidget {
  const RefundCancellationScreen({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          // White background for status bar area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top,
            child: Container(color:AppColors.backgroundWhite,),
          ),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.backgroundWhite,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  surfaceTintColor: Colors.transparent,
                  pinned: false,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Text(
                    'Refund & Cancellation Policy',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
                  ),
                  centerTitle: true,
                ),
                      SliverPadding(
                        padding: EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            _buildSection(
              number: '1',
              title: 'Introduction',
              content: 'At GrabShare, your privacy is important to us. This Privacy and Cookie Policy explains how we collect, use, and protect your information when you access or use our website, mobile platform, tools, or any related services. By using GrabShare, you agree to the collection and use of information in accordance with this policy.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '2',
              title: 'Information We Collect',
              content: 'We collect both personal and non-personal data to provide, improve, and secure your experience.\n\na. Personal Information\nCollected when you register or interact with the platform:\n• Full name\n• Email address\n• Phone number\n• UPI ID or bank details (for payouts)\n• Social media handles (e.g., Instagram, YouTube)\n• Profile photo and description\n\nb. Non-Personal Information\nCollected automatically when you use our platform:\n• IP address and approximate geolocation\n• Device information (browser type, OS)\n• Usage behavior (pages visited, clicks, session time)\n• Cookies and analytics data',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '3',
              title: 'How We Use Your Information',
              content: 'Your information is used to:\n• Create and manage your GrabShare account\n• Process affiliate rewards and payouts\n• Personalize your public profile and user dashboard\n• Provide customer support and resolve issues\n• Send updates, promotions, and service announcements (opt-out available)\n• Analyze usage trends to improve performance and features\n• Prevent fraud, misuse, or abuse of the platform',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '4',
              title: 'Cookies & Tracking Technologies',
              content: 'GrabShare uses cookies and similar technologies to:\n• Maintain user sessions\n• Remember login preferences\n• Analyze traffic and improve performance\n\nYou may manage or disable cookies in your browser settings, but this could affect your experience on the platform.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '5',
              title: 'Data Sharing',
              content: 'We do not sell or rent your personal data. We may share your data only with:\n• Affiliate networks or partner platforms (for tracking & payouts)\n• Service providers (e.g., payment gateways, analytics tools)\n• Legal or regulatory authorities if required by law\n• With your consent (e.g., when connecting social accounts)',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '6',
              title: 'Data Storage & Security',
              content: 'We implement appropriate technical and organizational measures to protect your data from unauthorized access, loss, or misuse. However, no online platform is 100% secure. Use strong passwords and protect your login credentials.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '7',
              title: 'Your Rights',
              content: 'You have the right to:\n• Access and review your personal data\n• Correct or update your account information\n• Request data deletion (subject to business/legal requirements)\n• Opt-out of promotional communications\n\nTo exercise these rights, contact us at support@grabshare.in.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '8',
              title: 'Children\'s Privacy',
              content: 'GrabShare is not intended for users under the age of 16. We do not knowingly collect data from minors. If we learn we\'ve collected data from a child without verification, we will delete it promptly.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '9',
              title: 'Third-Party Links',
              content: 'GrabShare may contain links to third-party websites or affiliate programs. We are not responsible for their privacy practices. Please review their policies before interacting.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '10',
              title: 'Changes to This Policy',
              content: 'We may update this Privacy Policy from time to time. Changes will be posted on this page with a revised "Effective Date." Continued use of the platform after updates constitutes acceptance of the revised policy.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '11',
              title: 'Contact Us',
              content: 'For any questions or concerns about this Privacy Policy, please reach out to:\n• support@grabshare.in\n• InspireLabs Solutions Pvt Ltd',
            ),
                            SizedBox(height: 24),
                          ]),
                        ),
                      ),
                      // Bottom container with black rounded bar - outside padding
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: AppColors.backgroundWhite,
                          padding: EdgeInsets.only(top: 8, bottom: MediaQuery.of(context).padding.bottom),
                          child: Center(
                            child: Container(
                              width: 134,
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppColors.textBlack,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

