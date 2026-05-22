import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'components/header_section.dart';

import 'components/pet_type_selection.dart';
import 'components/spotlight_picks.dart';
import 'components/curated_spa_center.dart';
import 'components/explore_section.dart';
import 'components/spa_centers_list.dart';

class PetSpaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Header section with teal-green background
            HeaderSection(),
            // Main content container with border radius - overlapping header
            Transform.translate(
              offset: Offset(0, -14),
              child: _buildMainContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        
        // Pet type selection - Full width with no horizontal padding
        // PetTypeSelection(),
        
        SizedBox(height: 32),
        
        // Spotlight Picks - Full width carousel
        SpotlightPicks(),
        
        // Curated Spa Center - Full width with no horizontal padding
        CuratedSpaCenter(),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              
              // Explore Pet Spa Centers
              ExploreSection(),
              
              SizedBox(height: 16),
              
              // Spa center cards
              SpaCentersList(),
            ],
          ),
        ),
      ],
    );
  }
}