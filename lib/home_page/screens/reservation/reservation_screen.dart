import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/date_selection_section.dart';
import 'components/time_selection_section.dart';
import 'components/option_selection_section.dart';
import 'components/reservation_footer.dart';
import 'components/customer_details_bottom_sheet.dart';
import '../booking_summary/booking_summary_screen.dart';

class ReservationScreen extends StatefulWidget {
  final String venueName;
  final String distance;

  const ReservationScreen({
    Key? key,
    required this.venueName,
    required this.distance,
  }) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int selectedDateIndex = 0;
  String? selectedTime;
  int selectedOptionIndex = 0;

  final List<Map<String, dynamic>> dates = [
    {'day': 'Today', 'date': '18 Oct', 'hasOffer': false},
    {'day': 'Sun', 'date': '19 Oct', 'hasOffer': true},
    {'day': 'Mon', 'date': '20 Oct', 'hasOffer': false},
    {'day': 'Tue', 'date': '21 Oct', 'hasOffer': true},
    {'day': 'Wed', 'date': '22 Oct', 'hasOffer': false},
    {'day': 'Thu', 'date': '23 Oct', 'hasOffer': false},
    {'day': 'Fri', 'date': '24 Oct', 'hasOffer': false},
  ];

  final List<String> timeSlots = [
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
  ];

  final List<Map<String, dynamic>> options = [
    {
      'title': 'Flat 25% OFF on total bill',
      'subtitle': 'Redeemable cover charge: ₹50',
      'hasOffer': true,
    },
    {
      'title': 'Standard Reservation',
      'subtitle': 'No cover charge required',
      'hasOffer': false,
    },
  ];

  bool get isProceedEnabled {
    return selectedDateIndex >= 0 &&
        selectedTime != null &&
        selectedOptionIndex >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reserve',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  widget.venueName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textGrey,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  widget.distance,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Date selection
                  DateSelectionSection(
                    dates: dates,
                    selectedDateIndex: selectedDateIndex,
                    onDateSelected: (index) {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                  ),
                  // Time selection
                  TimeSelectionSection(
                    timeSlots: timeSlots,
                    selectedTime: selectedTime,
                    onTimeSelected: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                  ),
                  // Option selection
                  OptionSelectionSection(
                    options: options,
                    selectedOptionIndex: selectedOptionIndex,
                    onOptionSelected: (index) {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ReservationFooter(
        isEnabled: isProceedEnabled,
        onProceed: () {
          if (isProceedEnabled) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CustomerDetailsBottomSheet(
                    onContinue: () {
                      Navigator.pop(context); // Close bottom sheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSummaryScreen(
                            venueName: widget.venueName,
                            city: 'Hyderabad',
                            dateTime:
                                '${dates[selectedDateIndex]['date']}, ${selectedTime}',
                            address: 'Lingampally, BHEL road',
                            discountText: options[selectedOptionIndex]['title'],
                            coverChargeText: options[selectedOptionIndex]
                                ['subtitle'],
                            coverChargeAmount: '₹50.00',
                            totalAmount: '₹50.00',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
