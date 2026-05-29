import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class CouponsOffersScreen extends StatefulWidget {
  final double currentBillAmount;

  const CouponsOffersScreen({
    super.key,
    required this.currentBillAmount,
  });

  @override
  State<CouponsOffersScreen> createState() => _CouponsOffersScreenState();
}

class _CouponsOffersScreenState extends State<CouponsOffersScreen> {
  final TextEditingController _couponController = TextEditingController();
  String? _selectedCouponCode;
  double _calculatedDiscount = 0.0;
  String? _couponTitle;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _selectCoupon(String code, double discount, String title) {
    setState(() {
      _selectedCouponCode = code;
      _calculatedDiscount = discount;
      _couponTitle = title;
    });
    Navigator.pop(context, {
      'code': code,
      'discount': discount,
      'title': title,
    });
  }

  void _applyManualCoupon() {
    final code = _couponController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    if (code == 'GLMFREE25') {
      _selectCoupon('GLMFREE25', 25.0, '₹25 OFF');
    } else if (code == 'GLMFREE99') {
      _selectCoupon('GLMFREE99', 99.0, '₹99 OFF');
    } else if (code == 'GLMFLAT30') {
      _selectCoupon(
          'GLMFLAT30', widget.currentBillAmount * 0.30, 'Flat 30% OFF');
    } else if (code == 'HDFCX99') {
      _selectCoupon('HDFCX99', 99.0, 'Flat ₹99 OFF');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid coupon code entered.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmAndReturn() {
    if (_selectedCouponCode != null) {
      Navigator.pop(context, {
        'code': _selectedCouponCode,
        'discount': _calculatedDiscount,
        'title': _couponTitle,
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLightGrey,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Coupons & Offers',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
            fontFamily: 'Manrope',
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coupon Code Input row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10),
                            ),
                            border: Border.all(
                              color: AppColors.borderGrey,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _couponController,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryBlack,
                              fontFamily: 'Manrope',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter Coupon Code',
                              hintStyle: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textGrey,
                                fontFamily: 'Manrope',
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _applyManualCoupon,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          decoration: const BoxDecoration(
                            color: Color(0xFF7A1FA2), // Brand Purple
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Available Offers Title
                  Text(
                    'Available Offers',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryBlack,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Coupon Tickets list
                  _buildTicketCard(
                    code: 'GLMFREE25',
                    title: 'Flat ₹25 OFF',
                    subtitle: 'GLMFREE25',
                    iconWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.local_offer_outlined,
                          color: Color(0xFF28A745),
                          size: 20,
                        ),
                      ),
                    ),
                    rules: [
                      'Applicable only on more than 2 hours of duration',
                      'Applicable only on more than 2 hours of duration',
                    ],
                    discountValue: 25.0,
                  ),
                  const SizedBox(height: 16),

                  _buildTicketCard(
                    code: 'GLMFREE99',
                    title: '₹99 OFF',
                    subtitle: 'GLMFREE99',
                    iconWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.local_offer_outlined,
                          color: Color(0xFF7A1FA2),
                          size: 20,
                        ),
                      ),
                    ),
                    rules: [
                      'Applicable only on more than 2 hours of duration',
                    ],
                    discountValue: 99.0,
                  ),
                  const SizedBox(height: 16),

                  _buildTicketCard(
                    code: 'GLMFLAT30',
                    title: 'Flat 30% OFF',
                    subtitle: 'GLMFLAT30',
                    iconWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.percent_rounded,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),
                    rules: [
                      'Applicable only on more than 2 hours of duration',
                      'Applicable only on more than 2 hours of duration',
                    ],
                    discountValue: widget.currentBillAmount * 0.30,
                  ),
                  const SizedBox(height: 16),

                  _buildTicketCard(
                    code: 'HDFCX99',
                    title: 'Flat ₹99 OFF',
                    subtitle: 'HDFCX99',
                    iconWidget: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F5FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFF003366),
                          ),
                          child: Center(
                            child: Container(
                              width: 18,
                              height: 18,
                              color: Colors.white,
                              child: Center(
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  color: const Color(0xFFE31E24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    rules: [
                      'Applicable only on more than 2 hours of duration',
                      'Applicable only on more than 2 hours of duration',
                    ],
                    discountValue: 99.0,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Sticky Bottom pay bill button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _confirmAndReturn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A1FA2), // Brand Purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Pay Bill',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Manrope',
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

  Widget _buildTicketCard({
    required String code,
    required String title,
    required String subtitle,
    required Widget iconWidget,
    required List<String> rules,
    required double discountValue,
  }) {
    final bool isSelected = _selectedCouponCode == code;

    return GestureDetector(
      onTap: () => _selectCoupon(code, discountValue, title),
      child: Stack(
        children: [
          // White ticket background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF7A1FA2) : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top section of the ticket card
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      iconWidget,
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryBlack,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textGrey,
                                fontFamily: 'Manrope',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Dashed Line Separator
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: DashedLinePainter(
                    color: Colors.grey[200]!,
                  ),
                ),

                // Bottom section (Rules list)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rules.map((rule) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textGrey,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                rule,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textGrey,
                                  fontFamily: 'Manrope',
                                  height: 1.25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Overlaid background half-circles on the left and right edges to represent ticket cutouts visually
          Positioned(
            left: -8,
            top: 68, // Aligned directly with the dashed line
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.backgroundLightGrey, // Matches page background
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -8,
            top: 68, // Aligned directly with the dashed line
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.backgroundLightGrey, // Matches page background
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6;
    double dashSpace = 4;
    double startX =
        12; // Inward padding so it doesn't overlap the cutout bounds completely
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startX < size.width - 12) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
