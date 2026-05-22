import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:glamease/constants/app_strings.dart';
import 'package:sizer/sizer.dart';

class PetDetailScreen extends StatefulWidget {
  final bool isEditMode;
  final String? petId;

  const PetDetailScreen({
    Key? key,
    this.isEditMode = true,
    this.petId,
  }) : super(key: key);

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  final TextEditingController _nameController = TextEditingController(text: AppStrings.tommy);
  final TextEditingController _speciesController = TextEditingController(text: AppStrings.dog);
  final TextEditingController _breedController = TextEditingController(text: AppStrings.goldenRetriever);
  final TextEditingController _ageController = TextEditingController(text: AppStrings.twoYears);
  final TextEditingController _genderController = TextEditingController(text: AppStrings.male);
  final TextEditingController _vaccinationController = TextEditingController(text: AppStrings.completed);
  final TextEditingController _weightController = TextEditingController(text: AppStrings.tenKgs);
  final TextEditingController _medicalConditionsController = TextEditingController(text: AppStrings.noAllergies);

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
                        AppStrings.myPet,
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
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.borderGrey,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/icons/pet_icon_round.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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
                            ),

                            SizedBox(height: 20),

                            // Species Field
                            _buildDropdownField(
                              label: AppStrings.species,
                              controller: _speciesController,
                            ),

                            SizedBox(height: 20),

                            // Breed Field
                            _buildDropdownField(
                              label: AppStrings.breed,
                              controller: _breedController,
                            ),

                            SizedBox(height: 20),

                            // Age Field
                            _buildTextField(
                              label: AppStrings.age,
                              controller: _ageController,
                            ),

                            SizedBox(height: 20),

                            // Gender Field
                            _buildTextField(
                              label: AppStrings.gender,
                              controller: _genderController,
                            ),

                            SizedBox(height: 20),

                            // Vaccination Field
                            _buildDropdownField(
                              label: AppStrings.vaccination,
                              controller: _vaccinationController,
                            ),

                            SizedBox(height: 20),

                            // Weight Field
                            _buildTextField(
                              label: AppStrings.weight,
                              controller: _weightController,
                            ),

                            SizedBox(height: 20),

                            // Medical Conditions / Allergies Field
                            _buildTextField(
                              label: AppStrings.medicalConditionsAllergies,
                              controller: _medicalConditionsController,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // Delete Button
                            if (widget.isEditMode)
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    // Handle delete
                                  },
                                  child: Text(
                                    AppStrings.delete,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textRed,
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.isEditMode) SizedBox(width: 16),
                            // Save Button
                            Expanded(
                              child: Container(
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
              color: AppColors.borderGrey,
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
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

  Widget _buildDropdownField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textBlack,
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
            readOnly: true,
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

