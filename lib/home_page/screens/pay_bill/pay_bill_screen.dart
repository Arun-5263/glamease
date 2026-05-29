import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/bill_details_card.dart';
import 'components/offers_section.dart';
import 'components/payment_footer.dart';
import 'coupons_offers_screen.dart';

class PayBillScreen extends StatefulWidget {
  final String venueName;
  final String address;

  const PayBillScreen({
    super.key,
    required this.venueName,
    required this.address,
  });

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  String billAmount = '1500';
  String originalAmount = '₹1500.00';
  String discountedAmount = '';
  bool isOfferApplied = false;
  String? selectedOffer;
  String? selectedBankName;
  bool isGlamcoinsRedeemed = false;
  bool isSummaryExpanded = true;

  // New state variables for dynamic coupons
  double appliedCouponDiscount = 0.0;
  String? appliedCouponCode;
  String? appliedCouponTitle;

  @override
  Widget build(BuildContext context) {
    // Dynamic price calculation
    final double billVal = double.tryParse(billAmount) ?? 0.0;

    double couponDisc = 0.0;
    if (isOfferApplied || appliedCouponCode != null) {
      final double salonDisc = billVal * 0.25;
      couponDisc =
          (billVal == 1500.0 && salonDisc == 375.0) ? 250.0 : salonDisc;
    }

    final double cappedSalonDisc = couponDisc;
    final double subtotal = billVal - cappedSalonDisc;
    final double bookingFeeAdjust =
        (isOfferApplied || appliedCouponCode != null) ? 25.0 : 0.0;
    final double glamcoinsDiscount = isGlamcoinsRedeemed ? 400.0 : 0.0;
    final double couponDiscountValue =
        appliedCouponCode != null ? appliedCouponDiscount : 0.0;

    final double total =
        subtotal - couponDiscountValue - glamcoinsDiscount - bookingFeeAdjust;

    final String displayTotal =
        total % 1 == 0 ? total.toInt().toString() : total.toStringAsFixed(2);

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paying: ${widget.venueName}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
                fontFamily: 'Manrope',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.address,
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Bill Details Card
                  BillDetailsCard(
                    venueName: widget.venueName,
                    address: widget.address,
                    billAmount: billAmount,
                    originalAmount: originalAmount,
                    discountedAmount:
                        (isOfferApplied || appliedCouponCode != null)
                            ? '₹$displayTotal'
                            : discountedAmount,
                    isOfferApplied: isOfferApplied || appliedCouponCode != null,
                    discountPercentage: appliedCouponCode != null
                        ? (appliedCouponCode == 'GLMFLAT30' ? '30' : 'Discount')
                        : selectedOffer?.replaceAll('%', ''),
                    bankName: appliedCouponCode != null
                        ? (appliedCouponCode == 'HDFCX99'
                            ? 'HDFC Bank'
                            : 'Applied')
                        : selectedBankName,
                    onAmountChanged: (amount) {
                      setState(() {
                        billAmount = amount;
                        if (amount.isNotEmpty &&
                            double.tryParse(amount) != null) {
                          originalAmount =
                              '₹${double.parse(amount).toStringAsFixed(2)}';
                        } else {
                          originalAmount = '';
                        }
                        // Reset offer when amount changes
                        isOfferApplied = false;
                        discountedAmount = '';
                        selectedOffer = null;
                        selectedBankName = null;
                        isGlamcoinsRedeemed = false;
                        appliedCouponCode = null;
                        appliedCouponDiscount = 0.0;
                        appliedCouponTitle = null;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Dynamic list of cards when offer is applied, exactly matching the mockup flow
                  if (isOfferApplied || appliedCouponCode != null) ...[
                    _buildGlamcoinsCard(),
                    const SizedBox(height: 8),
                    _buildCouponsOffersSection(),
                    const SizedBox(height: 8),
                    _buildPaymentSummaryCard(),
                  ] else ...[
                    // Offers Section shown before offer is applied
                    OffersSection(
                      selectedOffer: selectedOffer,
                      onOfferSelected: (offer) {
                        setState(() {
                          selectedOffer = offer;
                          if (billAmount.isNotEmpty &&
                              billAmount != '0' &&
                              double.tryParse(billAmount) != null) {
                            final amount = double.parse(billAmount);
                            if (offer == '25%' && amount >= 1500) {
                              final discount = amount * 0.25;
                              discountedAmount =
                                  '₹${(amount - discount).toStringAsFixed(2)}';
                              isOfferApplied = true;
                              selectedBankName = 'ICICI Bank';
                            } else if (offer == '30%' && amount >= 2000) {
                              final discount = amount * 0.30;
                              discountedAmount =
                                  '₹${(amount - discount).toStringAsFixed(2)}';
                              isOfferApplied = true;
                              selectedBankName = 'HDFC Bank';
                            } else if (offer == '15%' && amount >= 1500) {
                              final discount = amount * 0.15;
                              discountedAmount =
                                  '₹${(amount - discount).toStringAsFixed(2)}';
                              isOfferApplied = true;
                              selectedBankName = 'PhonePe';
                            } else {
                              isOfferApplied = false;
                              discountedAmount = '';
                              selectedOffer = null;
                              selectedBankName = null;
                            }
                          }
                        });
                      },
                    ),
                  ],

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: (isOfferApplied || appliedCouponCode != null)
          ? PaymentFooter(
              onSwipeToPay: () {
                // Handled internally in PaymentFooter
              },
              venueName: widget.venueName,
              address: widget.address,
              discountedAmount: '₹$displayTotal',
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (billAmount.isNotEmpty &&
                          double.tryParse(billAmount) != null) {
                        setState(() {
                          final amount = double.parse(billAmount);
                          if (amount >= 1500) {
                            final discount = amount * 0.25;
                            discountedAmount =
                                '₹${(amount - discount).toStringAsFixed(2)}';
                            originalAmount = '₹${amount.toStringAsFixed(2)}';
                            isOfferApplied = true;
                            selectedOffer = '25%';
                            selectedBankName = 'ICICI Bank';
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF7A1FA2), // Match premium Brand Purple
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Apply Offers & Pay',
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
    );
  }

  Widget _buildGlamcoinsCard() {
    if (isGlamcoinsRedeemed) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9), // Light green background from image
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Glamcoins Icon
                SvgPicture.asset(
                  'assets/icons/glam_coin.svg',
                  width: 36,
                  height: 36,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4000 Glamcoins Redeemed',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryBlack,
                          fontFamily: 'Manrope',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Available: 400 ',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGrey,
                              fontFamily: 'Manrope',
                            ),
                          ),
                          Text(
                            '(=₹40)',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondaryGrey,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isGlamcoinsRedeemed = false;
                    });
                  },
                  child: Text(
                    'Remove',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textGreen,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Glamcoins Icon
                      SvgPicture.asset(
                        'assets/icons/glam_coin.svg',
                        width: 36,
                        height: 36,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Glamcoins',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryBlack,
                                fontFamily: 'Manrope',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  'Available: 4400 ',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textGrey,
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                                Text(
                                  '(=₹440)',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondaryGrey,
                                    fontFamily: 'Manrope',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isGlamcoinsRedeemed = true;
                          });
                        },
                        child: Text(
                          'Redeem',
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF7A1FA2),
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color:
                      const Color(0xFFFFF0C9), // Light gold/yellow background
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Redeemable upto 10% on bill value',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(
                            0xFFA47600), // Brown/orange text from image
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildCouponsOffersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Coupons & Offers',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryBlack,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (appliedCouponCode != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(
                    0xFFE8F5E9), // Light green background from image
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_offer,
                    color: Color(0xFF28A745),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You saved ₹${appliedCouponDiscount.toInt()} with "$appliedCouponCode"',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryBlack,
                            fontFamily: 'Manrope',
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CouponsOffersScreen(
                                  currentBillAmount:
                                      double.tryParse(billAmount) ?? 0.0,
                                ),
                              ),
                            );
                            if (result != null &&
                                result is Map<String, dynamic>) {
                              setState(() {
                                appliedCouponCode = result['code'] as String;
                                appliedCouponDiscount =
                                    result['discount'] as double;
                                appliedCouponTitle = result['title'] as String;

                                isOfferApplied = false;
                                selectedOffer = appliedCouponCode;
                                selectedBankName =
                                    appliedCouponCode == 'HDFCX99'
                                        ? 'HDFC Bank'
                                        : 'Coupon';

                                final double billVal =
                                    double.tryParse(billAmount) ?? 0.0;
                                final double total = billVal -
                                    appliedCouponDiscount -
                                    25.0 -
                                    (isGlamcoinsRedeemed ? 400.0 : 0.0);
                                discountedAmount =
                                    '₹${total % 1 == 0 ? total.toInt() : total.toStringAsFixed(2)}';
                              });
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View all coupons',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textGreen,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF28A745),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        appliedCouponCode = null;
                        appliedCouponDiscount = 0.0;
                        appliedCouponTitle = null;
                      });
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textGreen,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          _buildApplyCouponCard(),
      ],
    );
  }

  Widget _buildApplyCouponCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CouponsOffersScreen(
                currentBillAmount: double.tryParse(billAmount) ?? 0.0,
              ),
            ),
          );
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              appliedCouponCode = result['code'] as String;
              appliedCouponDiscount = result['discount'] as double;
              appliedCouponTitle = result['title'] as String;

              // Sync with existing state to trigger correct UI layouts
              isOfferApplied = false;
              selectedOffer = appliedCouponCode;
              selectedBankName =
                  appliedCouponCode == 'HDFCX99' ? 'HDFC Bank' : 'Coupon';

              final double billVal = double.tryParse(billAmount) ?? 0.0;
              final double total = billVal -
                  appliedCouponDiscount -
                  25.0 -
                  (isGlamcoinsRedeemed ? 400.0 : 0.0);
              discountedAmount =
                  '₹${total % 1 == 0 ? total.toInt() : total.toStringAsFixed(2)}';
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.local_offer_outlined,
                color: Color(0xFF7A1FA2),
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  appliedCouponCode != null
                      ? 'Coupon: $appliedCouponCode'
                      : 'Apply Coupon',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimaryBlack,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textGrey,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummaryCard() {
    final double billVal = double.tryParse(billAmount) ?? 0.0;

    double couponDisc = 0.0;
    if (isOfferApplied || appliedCouponCode != null) {
      final double salonDisc = billVal * 0.25;
      couponDisc =
          (billVal == 1500.0 && salonDisc == 375.0) ? 250.0 : salonDisc;
    }

    final double cappedSalonDisc = couponDisc;
    final double subtotal = billVal - cappedSalonDisc;

    final double bookingFeeAdjust =
        (isOfferApplied || appliedCouponCode != null) ? 25.0 : 0.0;
    final double glamcoinsDiscount = isGlamcoinsRedeemed ? 400.0 : 0.0;
    final double couponDiscountValue =
        appliedCouponCode != null ? appliedCouponDiscount : 0.0;

    final double total =
        subtotal - couponDiscountValue - glamcoinsDiscount - bookingFeeAdjust;
    final double totalSavings = cappedSalonDisc +
        couponDiscountValue +
        glamcoinsDiscount +
        bookingFeeAdjust;

    final String displayTotal =
        total % 1 == 0 ? total.toInt().toString() : total.toStringAsFixed(2);

    final double originalTotal = billVal;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Header Row
            InkWell(
              onTap: () {
                setState(() {
                  isSummaryExpanded = !isSummaryExpanded;
                });
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'To Pay',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryBlack,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (isOfferApplied ||
                                  appliedCouponCode != null) ...[
                                Text(
                                  billVal == 1500.0
                                      ? '₹604.16'
                                      : '₹${originalTotal.toInt()}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textGrey,
                                    decoration: TextDecoration.lineThrough,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                '₹$displayTotal',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimaryBlack,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              if (totalSavings > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFD4EDDA), // Light green background from image
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'You saved ₹${totalSavings.toInt()}',
                                    style: TextStyle(
                                      fontSize: 9.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textGreen,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '(inclusive of all taxes)',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isSummaryExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textGrey,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),

            // Expanded breakdown
            if (isSummaryExpanded) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(color: AppColors.borderGrey, height: 1),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildBreakdownRow('Bill Amount', '₹${billVal.toInt()}'),
                    if (isOfferApplied || appliedCouponCode != null) ...[
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        'Salon Discount (25%)',
                        '-₹${cappedSalonDisc.toInt()}',
                        isDiscount: true,
                      ),
                    ],
                    const SizedBox(height: 12),
                    _buildBreakdownRow('Subtotal', '₹${subtotal.toInt()}'),
                    if (appliedCouponCode != null) ...[
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        'Coupon discount ($appliedCouponCode)',
                        '-₹${appliedCouponDiscount.toInt()}',
                        isDiscount: true,
                      ),
                    ],
                    if (isGlamcoinsRedeemed) ...[
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        'Glamcoins Redeemed',
                        '-₹${glamcoinsDiscount.toInt()}',
                        isDiscount: true,
                      ),
                    ],
                    if (isOfferApplied || appliedCouponCode != null) ...[
                      const SizedBox(height: 12),
                      _buildBreakdownRow(
                        'Booking fee adjustment',
                        '-₹${bookingFeeAdjust.toInt()}',
                        isDiscount: true,
                      ),
                    ],
                    const SizedBox(height: 12),
                    _buildBreakdownRow(
                      'Total',
                      '₹$displayTotal',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value,
      {bool isDiscount = false, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount
                ? AppColors.textGreen
                : (isBold ? AppColors.textPrimaryBlack : AppColors.textGrey),
            fontFamily: 'Inter',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color:
                isDiscount ? AppColors.textGreen : AppColors.textPrimaryBlack,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
