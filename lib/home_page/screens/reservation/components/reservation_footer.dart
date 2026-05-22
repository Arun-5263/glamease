import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';

class ReservationFooter extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onProceed;

  const ReservationFooter({
    Key? key,
    required this.isEnabled,
    required this.onProceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Transform.translate(
          offset: Offset(0, -8),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isEnabled ? onProceed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isEnabled ? AppColors.primaryOrange : Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
