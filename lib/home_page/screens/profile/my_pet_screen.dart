import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/constants/app_strings.dart';
import 'package:glamease/home_page/screens/profile/pet_detail_screen.dart';
import 'package:glamease/home_page/screens/profile/add_new_pet_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MyPetScreen extends StatelessWidget {
  const MyPetScreen({Key? key}) : super(key: key);

  static void _showPetOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable handle
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Edit Option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetDetailScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/pencil-square-edit.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Delete Option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmationDialog(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/delete.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          AppColors.textRed,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  static void _showDeleteConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Draggable handle
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 20),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Are you sure you want to delete ${AppStrings.tommy}?',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              // Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'You\'ll lose all info related to ${AppStrings.tommy}. This can\'t be undone.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              // Yes, Delete Option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete action
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/delete.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        colorFilter: ColorFilter.mode(
                          AppColors.textRed,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Yes, Delete',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Cancel Option
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.close,
                        color: AppColors.textPrimaryBlack,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimaryBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundWhite,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.backgroundGrey,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Row(
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
                        AppStrings.myPet,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryBlack,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40), // Balance space for back button
                ],
              ),

              // Main Content Area
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Pet Information Card
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetDetailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Pet Image
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.borderGrey,
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                       'assets/icons/pet_icon_round.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Pet Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.tommy,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimaryBlack,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${AppStrings.goldenRetriever}${AppStrings.petDetailsSeparator}${AppStrings.petAge}',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Options Icon
                                IconButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: AppColors.textPrimaryBlack,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    _showPetOptionsBottomSheet(context);
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),
              // Add Pet Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewPetScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                        child: Text(
                          AppStrings.addPet,
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
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

