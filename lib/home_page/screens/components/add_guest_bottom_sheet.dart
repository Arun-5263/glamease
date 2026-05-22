import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class AddGuestBottomSheet extends StatefulWidget {
  const AddGuestBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddGuestBottomSheet> createState() => _AddGuestBottomSheetState();
}

class _AddGuestBottomSheetState extends State<AddGuestBottomSheet> {
  int _guestCount = 1;

  void _decrementGuest() {
    if (_guestCount > 1) {
      setState(() {
        _guestCount--;
      });
    }
  }

  void _incrementGuest() {
    setState(() {
      _guestCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
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
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Title
          Center(
            child: Text(
              'Add Guest',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
          ),
          
          SizedBox(height: 24),
          
          // Guest counter input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Person icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                  ),
                  
                  SizedBox(width: 16),
                  
                  // Guests label
                  Expanded(
                    child: Text(
                      'Guests',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  
                  // Counter
                  Row(
                    children: [
                      // Minus button
                      GestureDetector(
                        onTap: _decrementGuest,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 16),
                      
                      // Number display
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: Text(
                          _guestCount.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 16),
                      
                      // Plus button
                      GestureDetector(
                        onTap: _incrementGuest,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          Spacer(),
          
          // Proceed button
          Container(
            padding: EdgeInsets.all(16),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _guestCount);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B46C1), // Purple color
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
}

