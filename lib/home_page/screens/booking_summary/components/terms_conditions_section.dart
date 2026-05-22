import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';

class TermsConditionsSection extends StatelessWidget {
  final List<String> terms;

  const TermsConditionsSection({
    Key? key,
    required this.terms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: TextStyle(
                 fontSize: 12.sp,
                       color: AppColors.textBlack,
                       fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 16),
          ...terms.map((term) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(top: 6, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    term,
                    style: TextStyle(
                     fontSize: 10.sp,
                       color: AppColors.textGrey,
                       fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
