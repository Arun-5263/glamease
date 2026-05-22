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
    Key? key,
    required this.venueName,
    required this.address,
    required this.billAmount,
    required this.originalAmount,
    required this.discountedAmount,
    required this.isOfferApplied,
    this.discountPercentage,
    this.bankName,
    required this.onAmountChanged,
  }) : super(key: key);

  @override
  _BillDetailsCardState createState() => _BillDetailsCardState();
}

class _BillDetailsCardState extends State<BillDetailsCard> {
  late TextEditingController _amountController;
  bool _isEditingAmount = false;
  late FocusNode _amountFocusNode;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.billAmount == '0' ? '' : widget.billAmount);
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
      _amountController.text = widget.billAmount == '0' ? '' : widget.billAmount;
    }
    if (oldWidget.isOfferApplied != widget.isOfferApplied && widget.isOfferApplied) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header text with dots/lines
            if (!widget.isOfferApplied)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
              Image.asset(
                'assets/icons/left_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
              Spacer(),
                         Text(
                      'Paying Bill to',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textBlack,
                      ),
                    ),
              Spacer(),
              Image.asset(
                'assets/icons/right_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
                        ],
                      ),
            )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 30, height: 1, color: AppColors.textGrey),
                  SizedBox(width: 8),
                  Text(
                    'Your bill',
                    style: TextStyle(
                    fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(width: 30, height: 1, color: AppColors.textGrey),
                ],
              ),
            
            SizedBox(height: 16),
            
            // Venue name
            Text(
              widget.venueName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
              ),
            ),
            
            SizedBox(height: 8),
            
            // Address
            Text(
              widget.address,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textGrey,
              ),
            ),
            
            SizedBox(height: 24),
            
            // Amount display
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
                            Future.delayed(Duration(milliseconds: 100), () {
                              _amountFocusNode.requestFocus();
                            });
                          },
                          child: Text(
                            widget.billAmount.isEmpty || widget.billAmount == '0' ? '₹0' : '₹${widget.billAmount}',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Divider(color: AppColors.borderGrey, height: 1),
                        SizedBox(height: 16),
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
                        SizedBox(height: 24),
                        Divider(color: AppColors.borderGrey, height: 1),
                        SizedBox(height: 16),
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
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Discounted amount
                  Text(
                    widget.discountedAmount,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  // Success message
                  Text(
                    'Hooray! ${widget.discountPercentage ?? '25'}% off discount applied',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textGreen,
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  // Coupon applied banner
                  if (widget.bankName != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.textGreen.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Coupon applied upto ${widget.discountPercentage ?? '20'}% OFF ${widget.bankName}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

