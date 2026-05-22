import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

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
                    'Terms and Conditions',
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
              content: 'These Terms and Conditions ("Terms") outline the rules and regulations for using GrabShare\'s website and services. By accessing or using GrabShare, you agree to be bound by these Terms. Please read them carefully to understand how GrabShare works and your responsibilities as a user.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '2',
              title: 'Membership',
              content: 'Eligibility: GrabShare is open to individuals aged 16 and above. You must provide accurate registration details, including your name, contact information, and payment method.\n\nProhibited Activities: You may not run paid advertisements (e.g., Google Ads, Facebook Ads) that link directly to GrabShare pages or platform URLs. Violations may result in immediate account suspension or termination.\n\nAccount Management: You are responsible for maintaining accurate account details, including your UPI ID and email. GrabShare is not liable for issues caused by outdated information.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '3',
              title: 'Our Service',
              content: 'GrabShare is a platform that allows "Creators" to create personalized sharing pages with links, media, and affiliate products, enabling them to earn through referrals or product sales.\n\nQualifying Activities: Earnings are generated from valid clicks, purchases, or tracked campaigns. Canceled, refunded, or fraudulent transactions do not qualify.\n\nEarnings & Commission Payouts: Payouts are made after GrabShare receives confirmation and commissions from partners. GrabShare is not obligated to pay for untracked or uncredited commissions.\n\nReferral Program: Users can earn referral bonuses by inviting others, provided the referred user is active, eligible, and both accounts remain in good standing.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '4',
              title: 'Earnings and Payments',
              content: 'Pending & Validated Payments: Earnings are marked "pending" until confirmed by partner networks, which can take up to 90 days. The minimum payout threshold is ₹10, and balances are forfeited if an account is closed before reaching this threshold.\n\nAdjustments & Reversals: GrabShare reserves the right to reverse or adjust earnings credited in error or due to fraudulent activity.\n\nNon-Qualifying Transactions: GrabShare is not responsible for missed or untracked earnings due to third-party system failures or browser restrictions.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '5',
              title: 'Your Responsibilities',
              content: 'Accuracy: Users agree to provide and maintain accurate profile information, including payment and contact details.\n\nCompliance: Users must comply with all applicable laws and terms from partner platforms or campaigns, with misuse or breach potentially leading to account suspension or termination.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '6',
              title: 'Intellectual Property',
              content: 'All content, design, branding, and features on GrabShare are owned by or licensed to InspireLabs Solutions Pvt Ltd. Users grant GrabShare a non-exclusive, royalty-free license to display, promote, or distribute user-shared content (e.g., links, thumbnails, text descriptions) within the platform.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '7',
              title: 'Privacy Policy',
              content: 'By using GrabShare, you agree to its Privacy Policy, which explains how data is collected, stored, and used.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '8',
              title: 'Disclaimer of Liability',
              content: 'GrabShare is not responsible for the quality, delivery, legality, or fulfillment of products or services listed or promoted via user-shared links, advising users to exercise caution with third-party platforms or products.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '9',
              title: 'Misuse of Services',
              content: 'GrabShare may suspend or terminate accounts for violating terms or engaging in fraudulent or harmful behavior, including submitting false information, using unauthorized payment/promotional methods, posting harmful/offensive/misleading content, or exploiting platform features for unintended use.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '10',
              title: 'Third-Party Interactions',
              content: 'If a partner, brand, or affiliate program contacts GrabShare regarding user content or activity, users agree to provide relevant information if requested. GrabShare may temporarily restrict access during investigations of third-party claims.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '11',
              title: 'Amendments & New Features',
              content: 'GrabShare may introduce new tools, features, or monetization options, with their usage subject to updated or additional terms shared via the platform.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '12',
              title: 'Termination',
              content: 'GrabShare reserves the right to terminate accounts involved in fraudulent behavior, misuse of services, or breach of terms. Any pending or unvalidated earnings may be forfeited upon termination.',
            ),
                            SizedBox(height: 12),
                            _buildSection(
              number: '13',
              title: 'Contact Information',
              content: 'For questions or support, please contact us at: support@grabshare.in',
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

