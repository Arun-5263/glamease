import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class BillDetailsCard extends StatefulWidget {
  final String venueName;
  final String address;
  final String billAmount;
  final String originalAmount;
  final String discountedAmount;
  final bool isOfferApplied;
  final String? discountPercentage;
  final String? bankName;
  final Function(String) onAmountChanged;

  const BillDetailsCard({
    super.key,
    required this.venueName,
    required this.address,
    required this.billAmount,
    required this.originalAmount,
    required this.discountedAmount,
    required this.isOfferApplied,
    this.discountPercentage,
    this.bankName,
    required this.onAmountChanged,
  });

  @override
  State<BillDetailsCard> createState() => _BillDetailsCardState();
}

class _BillDetailsCardState extends State<BillDetailsCard> {
  late TextEditingController _amountController;
  bool _isEditingAmount = false;
  late FocusNode _amountFocusNode;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
        text: widget.billAmount == '0' ? '' : widget.billAmount);
    _amountFocusNode = FocusNode();
    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        setState(() {
          _isEditingAmount = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(BillDetailsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.billAmount != widget.billAmount) {
      _amountController.text =
          widget.billAmount == '0' ? '' : widget.billAmount;
    }
    if (oldWidget.isOfferApplied != widget.isOfferApplied &&
        widget.isOfferApplied) {
      // Reset editing state when offer is applied
      _isEditingAmount = false;
      _amountFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  double _parseAmount(String val) {
    final clean = val.replaceAll('₹', '').replaceAll(',', '').trim();
    return double.tryParse(clean) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final orig = _parseAmount(widget.originalAmount);
    final disc = _parseAmount(widget.discountedAmount);
    final savings = orig - disc;
    final savingsText = savings % 1 == 0
        ? savings.toInt().toString()
        : savings.toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(
              16), // Match image's premium rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              16), // Clip bottom banner to match card corners
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main content of the card
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header text with dots/lines
                    if (!widget.isOfferApplied)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/left_line.png',
                            width: 15.w,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Paying Bill to',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/icons/right_line.png',
                            width: 15.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/left_line.png',
                            width: 15.w,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Your bill',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            'assets/icons/right_line.png',
                            width: 15.w,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                    const SizedBox(height: 20),

                    // Amount display/input section
                    if (!widget.isOfferApplied)
                      Column(
                        children: [
                          if (!_isEditingAmount)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEditingAmount = true;
                                    });
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      _amountFocusNode.requestFocus();
                                    });
                                  },
                                  child: Text(
                                    widget.billAmount.isEmpty ||
                                            widget.billAmount == '0'
                                        ? '₹0'
                                        : '₹${widget.billAmount}',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Divider(
                                    color: AppColors.borderGrey, height: 1),
                                const SizedBox(height: 16),
                                Text(
                                  'Enter total amount on bill',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _amountFocusNode.requestFocus();
                                        },
                                        child: Container(
                                          height: 40,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: _amountController,
                                        focusNode: _amountFocusNode,
                                        onChanged: widget.onAmountChanged,
                                        onSubmitted: (value) {
                                          setState(() {
                                            _isEditingAmount = false;
                                          });
                                          _amountFocusNode.unfocus();
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textGrey,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _amountFocusNode.requestFocus();
                                        },
                                        child: Container(
                                          height: 40,
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(
                                    color: AppColors.borderGrey, height: 1),
                                const SizedBox(height: 16),
                                Text(
                                  'Enter total amount on bill',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          // Original amount with strikethrough
                          Text(
                            widget.originalAmount,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGrey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Discounted amount
                          Text(
                            widget.discountedAmount,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textBlack,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Success message
                          Text(
                            'Hooray! ${widget.discountPercentage ?? '25'}% off discount applied',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors
                                  .textGreen, // Vibrant Green constant (28A745)
                            ),
                          ),

                          // Custom Coupon applied badge if present
                          // if (widget.bankName != null) ...[
                          //   const SizedBox(height: 10),
                          //   Container(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 12, vertical: 6),
                          //     decoration: BoxDecoration(
                          //       color: const Color(0xFFE8F5E9),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: Text(
                          //       'Coupon applied upto ${widget.discountPercentage ?? '20'}% OFF ${widget.bankName}',
                          //       style: TextStyle(
                          //         fontSize: 9.sp,
                          //         fontWeight: FontWeight.w500,
                          //         color: AppColors.textGreen,
                          //       ),
                          //     ),
                          //   ),
                          // ],
                        ],
                      ),
                  ],
                ),
              ),

              // Full-width light green savings banner at the bottom of the card
              if (widget.isOfferApplied && savings > 0)
                Container(
                  color: const Color(
                      0xFFD4EDDA), // Light green background from image
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'You will save ₹$savingsText on this booking',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors
                            .textGreen, // Vibrant Green constant (28A745)
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
