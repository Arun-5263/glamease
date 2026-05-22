import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/constants/app_strings.dart';
import 'package:sizer/sizer.dart';

class AddNewPetScreen extends StatefulWidget {
  const AddNewPetScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPetScreen> createState() => _AddNewPetScreenState();
}

class _AddNewPetScreenState extends State<AddNewPetScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _vaccinationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _medicalConditionsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _vaccinationController.dispose();
    _weightController.dispose();
    _medicalConditionsController.dispose();
    super.dispose();
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
                        AppStrings.addNewPet,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
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
                  child: Column(
                    children: [
                      SizedBox(height: 24),

                      // Pet Profile Picture
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              color: AppColors.borderGrey,
                              child: Icon(
                                Icons.add_a_photo,
                                color: AppColors.textGrey,
                                size: 40,
                              ),
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

                      SizedBox(height: 24),

                      // Pet Information Card
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 16),
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
                              hintText: 'Enter pet name',
                            ),

                            SizedBox(height: 20),

                            // Species Field
                            _buildDropdownField(
                              label: AppStrings.species,
                              controller: _speciesController,
                              hintText: 'Select species',
                            ),

                            SizedBox(height: 20),

                            // Breed Field
                            _buildDropdownField(
                              label: AppStrings.breed,
                              controller: _breedController,
                              hintText: 'Select breed',
                            ),

                            SizedBox(height: 20),

                            // Age Field
                            _buildTextField(
                              label: AppStrings.age,
                              controller: _ageController,
                              hintText: 'Enter age',
                            ),

                            SizedBox(height: 20),

                            // Gender Field
                            _buildTextField(
                              label: AppStrings.gender,
                              controller: _genderController,
                              hintText: 'Enter gender',
                            ),

                            SizedBox(height: 20),

                            // Vaccination Field
                            _buildDropdownField(
                              label: AppStrings.vaccination,
                              controller: _vaccinationController,
                              hintText: 'Select vaccination status',
                            ),

                            SizedBox(height: 20),

                            // Weight Field
                            _buildTextField(
                              label: AppStrings.weight,
                              controller: _weightController,
                              hintText: 'Enter weight',
                            ),

                            SizedBox(height: 20),

                            // Medical Conditions / Allergies Field
                            _buildTextField(
                              label: AppStrings.medicalConditionsAllergies,
                              controller: _medicalConditionsController,
                              hintText: 'Enter medical conditions or allergies',
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      // Save Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          width: double.infinity,
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
                      SizedBox(height: 16),
                    ],
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
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.textFieldBorderColor,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textFieldTextColor,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textLightGrey,
              ),
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

  Widget _buildDropdownField({
    required String label,
    required TextEditingController controller,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.textFieldBorderColor,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textFieldTextColor,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textLightGrey,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textPrimaryBlack,
                size: 24,
              ),
            ),
            onTap: () {
              // Handle dropdown selection
            },
          ),
        ),
      ],
    );
  }
}

