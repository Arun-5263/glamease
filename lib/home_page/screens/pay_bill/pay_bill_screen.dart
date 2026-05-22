import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/bill_details_card.dart';
import 'components/offers_section.dart';
import 'components/payment_footer.dart';

class PayBillScreen extends StatefulWidget {
  final String venueName;
  final String address;

  const PayBillScreen({
    Key? key,
    required this.venueName,
    required this.address,
  }) : super(key: key);

  @override
  _PayBillScreenState createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  String billAmount = '0';
  String originalAmount = '';
  String discountedAmount = '';
  bool isOfferApplied = false;
  String? selectedOffer;
  String? selectedBankName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundGrey,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  
                  // Bill Details Card
                  BillDetailsCard(
                    venueName: widget.venueName,
                    address: widget.address,
                    billAmount: billAmount,
                    originalAmount: originalAmount,
                    discountedAmount: discountedAmount,
                    isOfferApplied: isOfferApplied,
                    discountPercentage: selectedOffer?.replaceAll('%', ''),
                    bankName: selectedBankName,
                    onAmountChanged: (amount) {
                      setState(() {
                        billAmount = amount;
                        if (amount.isNotEmpty && double.tryParse(amount) != null) {
                          originalAmount = '₹${double.parse(amount).toStringAsFixed(2)}';
                        } else {
                          originalAmount = '';
                        }
                        // Reset offer when amount changes
                        isOfferApplied = false;
                        discountedAmount = '';
                        selectedOffer = null;
                        selectedBankName = null;
                      });
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Offers Section
                  OffersSection(
                    selectedOffer: selectedOffer,
                    onOfferSelected: (offer) {
                      setState(() {
                        selectedOffer = offer;
                        if (billAmount.isNotEmpty && billAmount != '0' && double.tryParse(billAmount) != null) {
                          final amount = double.parse(billAmount);
                          if (offer == '25%' && amount >= 1500) {
                            final discount = amount * 0.25;
                            discountedAmount = '₹${(amount - discount).toStringAsFixed(2)}';
                            isOfferApplied = true;
                            selectedBankName = 'ICICI Bank';
                          } else if (offer == '30%' && amount >= 2000) {
                            final discount = amount * 0.30;
                            discountedAmount = '₹${(amount - discount).toStringAsFixed(2)}';
                            isOfferApplied = true;
                            selectedBankName = 'HDFC Bank';
                          } else if (offer == '15%' && amount >= 1500) {
                            final discount = amount * 0.15;
                            discountedAmount = '₹${(amount - discount).toStringAsFixed(2)}';
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
                  
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isOfferApplied
          ? PaymentFooter(
              onSwipeToPay: () {
                // This callback is handled by the swipe button itself
              },
              venueName: widget.venueName,
              address: widget.address,
              discountedAmount: discountedAmount.isNotEmpty ? discountedAmount : originalAmount,
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (billAmount.isNotEmpty && double.tryParse(billAmount) != null) {
                        // Apply offers logic
                        setState(() {
                          final amount = double.parse(billAmount);
                          if (amount >= 1500) {
                            final discount = amount * 0.25;
                            discountedAmount = '₹${(amount - discount).toStringAsFixed(2)}';
                            originalAmount = '₹${amount.toStringAsFixed(2)}';
                            isOfferApplied = true;
                            selectedOffer = '25%';
                            selectedBankName = 'ICICI Bank';
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
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
}

