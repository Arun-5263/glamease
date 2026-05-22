import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? selectedIssueType;
  bool isDropdownOpen = false;
  final TextEditingController _issueController = TextEditingController();

  final List<String> issueTypes = [
    'Booking & payment issues',
    'Care center & service issues',
    'App & account issues',
    'Feature & usage issues',
    'Others',
  ];

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
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
          'Support',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select issue type
              Text(
                'Select issue type',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 12),
              // Dropdown field
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderGrey),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isDropdownOpen = !isDropdownOpen;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                selectedIssueType ?? 'Select',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: selectedIssueType != null
                                      ? AppColors.textBlack
                                      : AppColors.textGrey,
                                ),
                              ),
                            ),
                            Icon(
                              isDropdownOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.textGrey,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isDropdownOpen) ...[
                      Divider(color: AppColors.borderGrey, height: 1),
                      ...issueTypes.map((issueType) {
                        final isSelected = selectedIssueType == issueType;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIssueType = issueType;
                              isDropdownOpen = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    issueType,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check,
                                    color: AppColors.primaryOrange,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Tell us more about your issue
              Text(
                'Tell us more about your issue',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 12),
              // Text area
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderGrey),
                ),
                child: TextField(
                  controller: _issueController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Brief your issue here...',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Handle submit
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

