import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/header_image_section.dart';
import 'components/spa_info_section.dart';
import 'components/offers_section.dart';
import 'components/service_menu_section.dart';
import 'components/photos_section.dart';
import 'components/about_section.dart';
import 'components/reviews_section.dart';
import 'components/choose_appointment_type_bottom_sheet.dart';
import 'components/add_guest_bottom_sheet.dart';
import 'reservation/reservation_screen.dart';
import 'pay_bill/pay_bill_screen.dart';
import 'all_reviews_screen.dart';
import 'reservation/components/customer_details_bottom_sheet.dart';

class SpaDetailScreen extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String rating;
  final String address;
  final String hours;

  const SpaDetailScreen({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.address,
    required this.hours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with background image
            HeaderImageSection(
              onBackPressed: () => Navigator.pop(context),
              onFavoritePressed: () {
                // Handle favorite action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to favorites!')),
                );
              },
            ),
            // Main content
            _buildMainContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildMainContent() {
    final List<Map<String, dynamic>> sampleReviews = [
      {
        'name': 'Sarah Williams',
        'rating': 5.0,
        'text':
            'Absolutely stunning! The view was breathtaking, and the host was incredibly welcoming. Would definitely book again!',
        'timeAgo': '1 hour ago',
        'profileImageUrl': null,
      },
      {
        'name': 'John Smith',
        'rating': 4.0,
        'text':
            'Great service and friendly staff. The facilities were clean and well-maintained.',
        'timeAgo': '2 hours ago',
        'profileImageUrl': null,
      },
      {
        'name': 'Emily Johnson',
        'rating': 5.0,
        'text':
            'Excellent experience! Highly recommend this place for pet grooming services.',
        'timeAgo': '3 hours ago',
        'profileImageUrl': null,
      },
    ];

    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spa details section
            SpaInfoSection(
              title: title,
              distance: location,
              price: price,
              rating: rating,
              address: address,
              hours: hours,
              onGetDirections: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening directions...')),
                );
              },
              onInstagram: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening Instagram...')),
                );
              },
              onPhone: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening phone...')),
                );
              },
            ),
            SizedBox(height: 24),

            // Offers section - remove right padding
            ClipRect(
              child: OffersSection(
                offers: ['15% OFF', '15% OFF', '15% OFF'],
              ),
            ),
            SizedBox(height: 24),

            // Service Menu
            ServiceMenuSection(
              serviceMenus: [
                {
                  'title': 'Grooming Services',
                  'services':
                      '• Full Grooming - ₹800\n• Bath & Dry - ₹400\n• Nail Trimming - ₹200\n• Ear Cleaning - ₹150',
                },
                {
                  'title': 'Spa Services',
                  'services':
                      '• Pet Massage - ₹600\n• Aromatherapy - ₹500\n• Mud Bath - ₹700\n• Hot Oil Treatment - ₹400',
                },
              ],
            ),
            SizedBox(height: 24),

            // Photos
            PhotosSection(
              photoUrls: [
                'assets/images/photos.png',
                'assets/images/photos.png',
                'assets/images/photos.png',
                'assets/images/photos.png',
              ],
              onSeeAll: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening photo gallery...')),
                );
              },
            ),
            SizedBox(height: 24),

            // About
            AboutSection(
              aboutText:
                  'Fleur Aesthetics is a specialized Aesthetics services provider offering comprehensive beauty treatments including Fat Dissolving Injections, Dermal Fillers, Skin Tightening, and Anti-Wrinkle Injections. We focus on enhancing your natural beauty with professional care and attention to detail.',
            ),
            SizedBox(height: 24),

            // Reviews
            ReviewsSection(
              reviews: sampleReviews,
              sortBy: 'Newest',
              onSortChanged: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sorting reviews...')),
                );
              },
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllReviewsScreen(
                      reviews: sampleReviews,
                      averageRating: 4.0,
                      totalReviews: 52,
                      ratingBreakdown: const {
                        5: 24,
                        4: 14,
                        3: 9,
                        2: 4,
                        1: 1,
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => ChooseAppointmentTypeBottomSheet(),
                    ).then((selectedOption) {
                      if (selectedOption != null) {
                        if (selectedOption == 'group') {
                          // Show Add Guest bottom sheet for group appointment
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => AddGuestBottomSheet(),
                          ).then((guestCount) {
                            if (guestCount != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationScreen(
                                    venueName: title,
                                    distance: location,
                                  ),
                                ),
                              );
                            }
                          });
                        } else {
                          // For single appointment, navigate directly
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationScreen(
                                venueName: title,
                                distance: location,
                              ),
                            ),
                          );
                        }
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryOrange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Reserve Now',
                    style: TextStyle(
                        color: AppColors.primaryOrange,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
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
                            title: 'Confirm your details',
                            subtitle: 'Add your details to proceed',
                            buttonText: 'Continue to booking',
                            onContinue: () {
                              Navigator.pop(context); // Close bottom sheet
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PayBillScreen(
                                    venueName: title,
                                    address: address,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Pay Bill',
                    style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
