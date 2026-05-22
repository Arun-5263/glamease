import 'package:flutter/material.dart';
import 'components/payment_method_header.dart';
import 'components/upi_section.dart';
import 'components/card_section.dart';
import 'components/payment_method_footer.dart';
import '../booking_confirmed/booking_confirmed_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String currentMethod;
  final String? venueName;
  final String? city;
  final String? dateTime;
  final String? address;
  final String? coverChargeAmount;

  const PaymentMethodScreen({
    Key? key,
    required this.currentMethod,
    this.venueName,
    this.city,
    this.dateTime,
    this.address,
    this.coverChargeAmount,
  }) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = '';

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.currentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          PaymentMethodHeader(),
          
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // UPI Section
                  UPISection(
                    selectedMethod: selectedMethod,
                    onMethodSelected: (method) {
                      setState(() {
                        selectedMethod = method;
                      });
                    },
                  ),
                  
                  // Card Section
                  CardSection(
                    selectedMethod: selectedMethod,
                    onMethodSelected: (method) {
                      setState(() {
                        selectedMethod = method;
                      });
                    },
                    onAddNewCard: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening add new card form...')),
                      );
                    },
                  ),
                  
                  // Bottom padding for footer
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PaymentMethodFooter(
        isEnabled: selectedMethod.isNotEmpty,
        onProceed: () {
          if (selectedMethod.isNotEmpty) {
            // Generate UPI transaction number
            final upiTransactionNo = DateTime.now().millisecondsSinceEpoch.toString();
            
            // Navigate to Booking Confirmed screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmedScreen(
                  venueName: widget.venueName ?? 'Peek a Bow - The pet club',
                  city: widget.city ?? 'Hyderabad',
                  dateTime: widget.dateTime ?? '20 Oct, 12:00 PM',
                  address: widget.address ?? 'Lingampally, BHEL road',
                  coverChargeAmount: widget.coverChargeAmount ?? '₹ 50.00',
                  upiTransactionNo: upiTransactionNo,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
