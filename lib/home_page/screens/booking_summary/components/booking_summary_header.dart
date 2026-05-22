import 'package:flutter/material.dart';

class BookingSummaryHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String venueName;
  final String city;

  const BookingSummaryHeader({
    Key? key,
    required this.onBackPressed,
    required this.venueName,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Navigation bar with header text
            Row(
              children: [
                GestureDetector(
                  onTap: onBackPressed,
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venueName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        city,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        ),
      ),
    );
  }
}
