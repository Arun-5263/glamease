import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'reservation_screen.dart';

class Stylist {
  final String id;
  final String name;
  final double rating;
  final String specialty;
  final int experienceYears;
  final String? imageUrl;

  const Stylist({
    required this.id,
    required this.name,
    required this.rating,
    required this.specialty,
    required this.experienceYears,
    this.imageUrl,
  });
}

class SelectStylistScreen extends StatefulWidget {
  final String venueName;
  final String distance;

  const SelectStylistScreen({
    super.key,
    required this.venueName,
    required this.distance,
  });

  @override
  State<SelectStylistScreen> createState() => _SelectStylistScreenState();
}

class _SelectStylistScreenState extends State<SelectStylistScreen> {
  String? _selectedStylistId;

  final List<Stylist> _stylists = const [
    Stylist(
      id: 'no_preference',
      name: 'No Preference',
      rating: 0.0,
      specialty: 'Any available stylist will be assigned',
      experienceYears: 0,
    ),
    Stylist(
      id: 'jimmy',
      name: 'Jimmy Jackson',
      rating: 4.9,
      specialty: "Women's Hair Stylist",
      experienceYears: 4,
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
    ),
    Stylist(
      id: 'sophia',
      name: 'Sophia Martinez',
      rating: 4.9,
      specialty: 'Makeup Artist',
      experienceYears: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=200',
    ),
    Stylist(
      id: 'liam',
      name: "Liam O'Connor",
      rating: 4.9,
      specialty: 'Barber',
      experienceYears: 5,
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
    ),
    Stylist(
      id: 'aisha',
      name: 'Aisha Khan',
      rating: 4.9,
      specialty: 'Nail Technician',
      experienceYears: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&q=80&w=200',
    ),
    Stylist(
      id: 'carlos',
      name: 'Carlos Rivera',
      rating: 4.9,
      specialty: "Men's Hair Stylist",
      experienceYears: 7,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=200',
    ),
    Stylist(
      id: 'emily',
      name: 'Emily Chen',
      rating: 4.9,
      specialty: 'Color Specialist',
      experienceYears: 4,
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Stylist',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _stylists.length,
              itemBuilder: (context, index) {
                final stylist = _stylists[index];
                final isSelected = stylist.id == _selectedStylistId;

                return Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: _buildStylistCard(stylist, isSelected),
                );
              },
            ),
          ),

          // Continue Button Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedStylistId != null
                      ? () {
                          final selectedStylist = _stylists
                              .firstWhere((s) => s.id == _selectedStylistId);
                          // Navigate to ReservationScreen (DateSelectionSection)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationScreen(
                                venueName: widget.venueName,
                                distance: widget.distance,
                                stylistName: selectedStylist.name,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF6B46C1), // Brand Purple color
                    disabledBackgroundColor:
                        const Color(0xFFCCCCCC), // Disabled grey
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStylistCard(Stylist stylist, bool isSelected) {
    final isNoPreference = stylist.id == 'no_preference';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStylistId = stylist.id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6B46C1) // Purple border when selected
                : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Avatar
            if (isNoPreference)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.group_outlined,
                  color: Colors.black87,
                  size: 26,
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  stylist.imageUrl!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 56,
                      height: 56,
                      color: const Color(0xFFF3F4F6),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF6B46C1)),
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 56,
                      height: 56,
                      color: const Color(0xFFF3F4F6),
                      child: const Icon(Icons.person, color: Colors.grey),
                    );
                  },
                ),
              ),

            const SizedBox(width: 16),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          stylist.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      if (!isNoPreference) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFBBF24), // Yellow Star
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                stylist.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4B5563),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: stylist.specialty),
                        if (!isNoPreference) ...[
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFF6B7280),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          TextSpan(text: '${stylist.experienceYears} yrs exp'),
                        ],
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
