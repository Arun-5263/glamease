import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/transaction_successful_header.dart';
import 'components/transaction_offers_section.dart';
import 'components/payment_receipt.dart';


class TransactionSuccessfulScreen extends StatefulWidget {
  final String? transactionDate;
  final bool isPending;
  final bool isFailed;

  TransactionSuccessfulScreen({
    Key? key,
    String? transactionDate,
    this.isPending = false,
    this.isFailed = false,
  })  : transactionDate = transactionDate ?? _formatDateTime(DateTime.now()),
        super(key: key);

  static String _formatDateTime(DateTime dateTime) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$day $month, $hour:$minute $period';
  }

  @override
  _TransactionSuccessfulScreenState createState() => _TransactionSuccessfulScreenState();
}

class _TransactionSuccessfulScreenState extends State<TransactionSuccessfulScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _clipAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds:1000),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.2, curve: Curves.easeIn),
    ));

    // Clip animation - progressive reveal from top to bottom (bottom comes out slowly)
    // This creates the roll-out effect where bottom part appears last
    _clipAnimation = Tween<double>(
      begin: 0.0, // Start with nothing visible
      end: 1.0, // Fully revealed
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    ));

    // Start animation when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight,
              ),
              child: Column(
                children: [
                  // Stack to overlay receipt opener on header
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      TransactionSuccessfulHeader(
                        transactionDate: widget.transactionDate ?? '',
                        isPending: widget.isPending,
                        isFailed: widget.isFailed,
                      ),
                      // Receipt opener image - changes to opened when animation starts
                      Positioned(
                        top: 15.h,
                        left: 10,
                        right: 10,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            // Switch to opened image when animation starts (value > 0)
                            final isOpened = _animationController.value > 0;
                            return Image.asset(
                              isOpened 
                                  ? 'assets/images/receipt_opened.png'
                                  : 'assets/images/receipt_opener.png',
                              fit: BoxFit.contain,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  // Animated Receipt - rolling down from receipt opener with roll-out effect
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: _clipAnimation.value,
                            widthFactor: 1.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  alignment: Alignment.topCenter,
                                  clipBehavior: Clip.none,
                                  children: [
                                    // Receipt background image - full height preserved
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Image.asset(
                                        widget.isFailed
                                            ? 'assets/images/failed_receipt.png'
                                            : (widget.isPending 
                                                ? 'assets/images/processing_receipt.png'
                                                : 'assets/images/receipt.png'),
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                      ),
                                    ),
                                    // Payment receipt content overlay - positioned inside receipt
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: PaymentReceipt(
                                        isPending: widget.isPending,
                                        isFailed: widget.isFailed,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Offers For You section with padding - moved to bottom (only show when not pending)
                  if (!widget.isPending)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TransactionOffersSection(),
                    ),
                  if (!widget.isPending) SizedBox(height: 24),
                  
                  // Need Help Contact Us section (for all transactions, not sticky)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.textPrimaryBlack),
                          SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textPrimaryBlack,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Need Help? ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Contact Us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: (widget.isPending || widget.isFailed)
          ? null
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home - pop all screens
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Home',
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

