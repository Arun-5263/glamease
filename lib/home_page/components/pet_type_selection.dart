import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PetTypeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/icons/left_line.png',
              width: 15.w,
              height: 3.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
            Spacer(),
            Text(
              "Choose your pet's spa type",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/icons/right_line.png',
              width: 15.w,
              height: 3.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox.shrink();
              },
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(
                      'assets/icons/dog.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.pets,
                          size: 60,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Transform.scale(
                    scale: 1.5,
                    child: Image.asset(
                      'assets/icons/cat.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.pets,
                          size: 60,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
