import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class ChoosePetBottomSheet extends StatefulWidget {
  const ChoosePetBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChoosePetBottomSheet> createState() => _ChoosePetBottomSheetState();
}

class _ChoosePetBottomSheetState extends State<ChoosePetBottomSheet> {
  String? _selectedPetId;

  final List<Map<String, dynamic>> _pets = [
    {
      'id': '1',
      'name': 'Max',
      'breed': 'Golden Retriever',
      'image': 'assets/icons/dog.png',
    },
    {
      'id': '2',
      'name': 'Kitty',
      'breed': 'Persian',
      'image': 'assets/icons/cat.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Title
          Center(
            child: Text(
              'Choose your pet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Pet list
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ..._pets.map((pet) => _buildPetCard(pet)).toList(),
                  
             
                  
                  // Add New Pet option - centered
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Handle add new pet
                        Navigator.pop(context);
                        // Navigate to add new pet screen
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: 24,
                              color: AppColors.textBlack,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add New Pet',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Proceed button
          Container(
            padding: EdgeInsets.all(16),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _selectedPetId != null
                      ? () {
                          Navigator.pop(context, _selectedPetId);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    disabledBackgroundColor: AppColors.grey300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet) {
    final isSelected = _selectedPetId == pet['id'];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPetId = pet['id'];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.grey300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Pet image - square
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                pet['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.grey300,
                    child: Icon(
                      Icons.pets,
                      size: 40,
                      color: AppColors.grey500,
                    ),
                  );
                },
              ),
            ),
            
            SizedBox(width: 16),
            
            // Pet name and breed
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet['name'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    pet['breed'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryOrange
                      : AppColors.textBlack,
                
                ),
                color: isSelected
                    ? AppColors.primaryOrange
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.textWhite,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

