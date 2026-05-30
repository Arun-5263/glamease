import 'package:flutter/material.dart';

class HeaderImageSection extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onSharePressed;

  const HeaderImageSection({
    Key? key,
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          // Background image - spa_center
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/spa_center.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for better text visibility
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
          // Navigation buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onBackPressed,
                    child: Image.asset(
                      'assets/icons/back.png',
                      width: 35,
                      height: 35,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onFavoritePressed,
                        child: Image.asset(
                          'assets/icons/fav.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: onSharePressed,
                        child: Image.asset(
                          'assets/icons/share_icon.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Curved bottom edge
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: 20,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
