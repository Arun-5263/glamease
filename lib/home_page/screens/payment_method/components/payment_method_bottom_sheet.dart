import 'package:flutter/material.dart';
import 'payment_method_header.dart';
import 'upi_section.dart';
import 'card_section.dart';
import 'payment_method_footer.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  final String currentMethod;
  final Function(String)? onProceedToBooking;

  const PaymentMethodBottomSheet({
    Key? key,
    required this.currentMethod,
    this.onProceedToBooking,
  }) : super(key: key);

  @override
  _PaymentMethodBottomSheetState createState() => _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  String selectedMethod = '';

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.currentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
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
          
          // Footer
          PaymentMethodFooter(
            isEnabled: selectedMethod.isNotEmpty,
            onProceed: () {
              if (selectedMethod.isNotEmpty) {
                if (widget.onProceedToBooking != null) {
                  // Call the callback to navigate to booking confirmed
                  widget.onProceedToBooking!(selectedMethod);
                  Navigator.pop(context);
                } else {
                  // Return the selected method to the previous screen
                  Navigator.pop(context, selectedMethod);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
