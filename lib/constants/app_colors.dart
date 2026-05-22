import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryTeal = Color(0xFF4A9E88);
  static const Color primaryBlueGreen = Color(0xFF17A2B8);
  static const Color primaryOrange = Color(0xFFFF7A1FA2);
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color primaryLightOrange = Color(0xFFFFB74D);

  // Payment Method Colors
  static const Color googlePayBlue = Color(0xFF4285F4);
  static const Color googlePayGreen = Color(0xFF34A853);
  static const Color googlePayYellow = Color(0xFFFBBC05);
  static const Color googlePayRed = Color(0xFFEA4335);
  static const Color phonePePurple = Color(0xFF5B259F);
  static const Color mastercardRed = Color(0xFFEB001B);
  static const Color mastercardOrange = Color(0xFFF79E1B);

  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color backgroundLightGrey = Color(0xFFF7F7F7);
  static const Color backgroundYellow = Color(0xFFFFF9C4);

  // Text Colors
  static const Color textBlack = Colors.black;
  static const Color textPrimaryBlack = Color(0xFF0D0D12);
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF808080);
  static const Color textLightGrey = Color(0xFF999999);
  static const Color textSecondaryGrey = Color(0xFFA4ACB9);
  static const Color textGreen = Colors.green;
  static const Color textBlue = Colors.blue;
  static const Color textRed = Color(0xFFEB001B);

  // Border and Shadow Colors
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color shadowBlack = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  static Color shadowVeryLight = Colors.black.withValues(alpha: 0.06);

  // Status Colors
  static const Color successGreen = Colors.green;
  static const Color errorRed = Colors.red;
  static const Color warningOrange = Colors.orange;
  static const Color infoBlue = Colors.blue;

  // Gradient Colors
  static const List<Color> googlePayGradient = [
    googlePayBlue,
    googlePayGreen,
    googlePayYellow,
    googlePayRed,
  ];

  static const List<Color> primaryGradient = [
    primaryTeal,
    primaryBlueGreen,
  ];

  static const List<Color> orangeGradient = [
    primaryGold,
    primaryLightOrange,
    primaryOrange,
  ];

  // Common Color Shades
  static Color grey50 = Colors.grey[50]!;
  static Color grey100 = Colors.grey[100]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;
  static Color grey800 = Colors.grey[800]!;
  static Color grey900 = Colors.grey[900]!;

  // Opacity Colors
  static Color whiteOpacity20 = Colors.white.withValues(alpha: 0.2);
  static Color whiteOpacity30 = Colors.white.withValues(alpha: 0.3);
  static Color whiteOpacity50 = Colors.white.withValues(alpha: 0.5);
  static Color whiteOpacity70 = Colors.white.withValues(alpha: 0.7);
  static Color blackOpacity10 = Colors.black.withValues(alpha: 0.1);
  static Color blackOpacity20 = Colors.black.withValues(alpha: 0.2);
  static Color blackOpacity30 = Colors.black.withValues(alpha: 0.3);
  static Color blackOpacity50 = Colors.black.withValues(alpha: 0.5);

  // UI Component Colors
  static const Color editButtonBlue = Color(0xFF4FC3F7); // Light blue for edit button
  static const Color saveButtonGrey = Color(0xFF9E9E9E); // Gray for save button
  static const Color textFieldTextColor = Color(0xFF5C6579); // Text field text color
  static const Color textFieldBorderColor = Color(0xFFF1F1F1); // Text field border color

  // Booking Status Colors
  static const Color transactionPendingBanner = Color(0xFFFFF9C4); // Light yellow for transaction pending
  static const Color transactionPendingText = Color(0xFFFF9800); // Orange text for transaction pending
  static const Color savedBanner = Color(0xFFE8F5E9); // Light green for saved amount
  static const Color savedText = Color(0xFF4CAF50); // Green text for saved amount
  static const Color bookingCancelledText = Color(0xFFEB001B); // Red for cancelled/failed
  static const Color tabSelectedBackground = Color(0xFFFFFFFF); // White for selected tab
  static const Color tabUnselectedBackground = Color(0xFFF5F5F5); // Light grey for unselected tab

  // Referral Colors
  static const Color referralPendingStatus = Color(0xFFFFB74D); // Yellowish-orange for pending status
  static const Color referralJoinedStatus = Color(0xFF4CAF50); // Green for joined status
  static const Color referralInputBackground = Color(0xFFF5F5F5); // Light grey for input field
}
