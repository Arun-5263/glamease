import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class FeedbackBottomSheet extends StatefulWidget {
  final String? selectedRating;
  
  const FeedbackBottomSheet({Key? key, this.selectedRating}) : super(key: key);

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  String? selectedAmbience;
  String? selectedService;
  String? selectedStaffBehaviour;
  final TextEditingController _feedbackController = TextEditingController();
  bool _showThankYou = false;
  Set<String> _selectedGoodOptions = {};

  final List<Map<String, String>> goodOptions = [
    {'icon': '💰', 'label': 'Easy payment'},
    {'icon': '⏱️', 'label': 'Quick process'},
    {'icon': '🎨', 'label': 'Clean design'},
    {'icon': '📋', 'label': 'Transparent pricing'},
  ];

  bool get _isBadExperience => widget.selectedRating == 'Terrible' || widget.selectedRating == 'Bad';
  bool get _isGoodExperience => widget.selectedRating == 'Good' || widget.selectedRating == 'Great';

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_showThankYou) {
      Navigator.pop(context);
    } else {
      setState(() {
        _showThankYou = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 20),
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.borderGrey,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          if (!_showThankYou) ...[
            if (_isBadExperience) 
              _buildBadExperienceView()
            else if (_isGoodExperience)
              _buildGoodExperienceView()
            else
              _buildDefaultView(),
          ] else ...[
            // Thank You Screen
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Party popper icon (using emoji or SVG if available)
                  Text(
                    '🎉',
                    style: TextStyle(fontSize: 48),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Thank you for your feedback!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'We appreciate your time!',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your feedback makes a big difference.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
          // Submit Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: _onSubmit,
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildRatingQuestion(String question, String? selectedValue, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRatingOption(
              'assets/icons/terrible_unselected.svg',
              'assets/icons/terrible.svg',
              'Terrible',
              selectedValue == 'Terrible',
              () => onSelect('Terrible'),
            ),
            _buildRatingOption(
              'assets/icons/bad_unselected.svg',
              'assets/icons/bad.svg',
              'Bad',
              selectedValue == 'Bad',
              () => onSelect('Bad'),
            ),
            _buildRatingOption(
              'assets/icons/okay_unselected.svg',
              'assets/icons/okay.svg',
              'Okay',
              selectedValue == 'Okay',
              () => onSelect('Okay'),
            ),
            _buildRatingOption(
              'assets/icons/good_unselected.svg',
              'assets/icons/good.svg',
              'Good',
              selectedValue == 'Good',
              () => onSelect('Good'),
            ),
            _buildRatingOption(
              'assets/icons/great_unselected.svg',
              'assets/icons/great.svg',
              'Great',
              selectedValue == 'Great',
              () => onSelect('Great'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingOption(String unselectedIconPath, String selectedIconPath, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              isSelected ? selectedIconPath : unselectedIconPath,
              width: 35,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.textGrey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadExperienceView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Bad icon with orange circle background
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/bad.svg',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Bad',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'We\'re really sorry to hear that 😔',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          // Text input
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Could you tell us what went wrong so we can make it better?',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
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
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGoodExperienceView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Good icon
          Center(
            child: SvgPicture.asset(
              'assets/icons/good.svg',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          
          Text(
            'Good',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'What did you like the most?',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Options grid - all same size
          Row(
            children: [
              Expanded(
                child: _buildGoodOption('Easy payment', '💰', 0),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildGoodOption('Quick process', '⏱️', 1),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildGoodOption('Clean design', '🎨', 2),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildGoodOption('Transparent pricing', '📋', 3),
              ),
            ],
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildGoodOption(String label, String icon, int index) {
    final isSelected = _selectedGoodOptions.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGoodOptions.remove(label);
          } else {
            _selectedGoodOptions.add(label);
          }
        });
      },
      child: Container(
        height: 50, // Fixed height to ensure all containers are same size
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange.withOpacity(0.1) : AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.borderGrey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              icon,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBlack,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // How was the Ambience
          _buildRatingQuestion(
            'How was the Ambience ?',
            selectedAmbience,
            (value) => setState(() => selectedAmbience = value),
          ),
          SizedBox(height: 24),
          // How was the Service
          _buildRatingQuestion(
            'How was the Service ?',
            selectedService,
            (value) => setState(() => selectedService = value),
          ),
          SizedBox(height: 24),
          // How was the Staff Behaviour
          _buildRatingQuestion(
            'How was the Staff Behaviour ?',
            selectedStaffBehaviour,
            (value) => setState(() => selectedStaffBehaviour = value),
          ),
          SizedBox(height: 24),
          // Text input
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your experience here...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
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
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

