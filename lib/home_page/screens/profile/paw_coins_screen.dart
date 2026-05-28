import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class PawCoinsScreen extends StatefulWidget {
  const PawCoinsScreen({Key? key}) : super(key: key);

  @override
  State<PawCoinsScreen> createState() => _PawCoinsScreenState();
}

class _PawCoinsScreenState extends State<PawCoinsScreen> {
  int _selectedFilterIndex = 0; // 0: All Activity, 1: Earned, 2: Spent

  // Mock transactions matching the mockup details
  final List<Map<String, dynamic>> _transactions = [
    {
      'transactionType': 'Tony & Guy',
      'transactionNo': '1232348998457',
      'amount': '-31.00',
      'isDebit': true,
      'date': '16 Jun, 09:31AM',
    },
    {
      'transactionType': 'Refund',
      'transactionNo': '1232348998457',
      'amount': '+211.00',
      'isDebit': false,
      'date': '16 Jun, 09:31AM',
    },
    {
      'transactionType': 'Login Bonus',
      'transactionNo': '1232348998457',
      'amount': '+211.00',
      'isDebit': false,
      'date': '16 Jun, 09:31AM',
    },
    {
      'transactionType': 'Meow-Spa',
      'transactionNo': '1232348998457',
      'amount': '-31.00',
      'isDebit': true,
      'date': '16 Jun, 09:31AM',
    },
    {
      'transactionType': 'Referral Bonus',
      'transactionNo': '1232348998457',
      'amount': '+211.00',
      'isDebit': false,
      'date': '16 Jun, 09:31AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter list based on selection
    final filteredTransactions = _transactions.where((txn) {
      if (_selectedFilterIndex == 0) return true;
      if (_selectedFilterIndex == 1) return !txn['isDebit']; // Earned
      if (_selectedFilterIndex == 2) return txn['isDebit']; // Spent
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'GlamCoins',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // White Header Section with rounded bottom corners
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),

                        // Large Jar Image
                        Image.asset(
                          'assets/icons/glam_jar.png',
                          width: 170,
                          height: 170,
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: 2.h),

                        // Coin balance row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/glam_coin.svg',
                              width: 28,
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '1,242 = ₹124.20',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // Conversion rate text
                        Text(
                          '10 Coin = ₹1 Rupee',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Transaction History Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Transaction History',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),

                  SizedBox(height: 1.5.h),

                  // Filter Tabs Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildFilterTab(0, 'All Activity'),
                        SizedBox(width: 8),
                        _buildFilterTab(1, 'Earned'),
                        SizedBox(width: 8),
                        _buildFilterTab(2, 'Spent'),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Transaction Cards List
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredTransactions.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final txn = filteredTransactions[index];
                        return _buildTransactionItem(
                          transactionType: txn['transactionType'],
                          transactionNo: txn['transactionNo'],
                          amount: txn['amount'],
                          isDebit: txn['isDebit'],
                          date: txn['date'],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.backgroundWhite,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle redeem coins
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF7A1FA2), // Brand Purple color from image
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: AppColors.textWhite,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Redeem Coins',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Handle how to redeem
                },
                child: Text(
                  'How to Redeem Coins?',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(int index, String label) {
    final isSelected = _selectedFilterIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF7A1FA2) : Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.textWhite : Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String transactionType,
    required String transactionNo,
    required String amount,
    required bool isDebit,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon Container
          Center(
            child: SvgPicture.asset(
              isDebit
                  ? 'assets/icons/debit_arrow.svg'
                  : 'assets/icons/Credit_arrow.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                isDebit ? AppColors.textGrey : Color(0xFF4CAF50),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionType,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Txn No: $transactionNo',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),

          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isDebit ? Color(0xFFEB001B) : Color(0xFF4CAF50),
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
