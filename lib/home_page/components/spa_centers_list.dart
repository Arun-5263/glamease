import 'package:flutter/material.dart';
import 'spa_center_card.dart';

class SpaCentersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpaCenterCard(
          title: 'Tony & Guy ',
          location: 'Lingampalli, BHEL... 2.3km',
          price: '₹900',
          rating: '4.9 (1,092 Reviews)',
          discount: 'Flat 40% OFF On First Booking',
          discountColor: Colors.green,
        ),
        SizedBox(height: 16),
        SpaCenterCard(
          title: 'Lakmee Saloon',
          location: 'Lingampalli, BHEL... 2.3km',
          price: '₹900',
          rating: '4.9 (1,092 Reviews)',
          discount: 'Flat 35% OFF On First Booking',
          discountColor: Colors.green,
        ),
        SizedBox(height: 16),
        SpaCenterCard(
          title: 'Marshal pet spa',
          location: 'Kukatpally, Rd-5 • 4.3km',
          price: '₹1200',
          rating: '4.9 (1,092 Reviews)',
          discount: 'Flat 10% OFF On First Booking',
          discountColor: Colors.orange,
        ),
      ],
    );
  }
}
