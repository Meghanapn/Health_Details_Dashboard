

// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_details/barchart.dart';


// Section controller to manage which section is expanded
class SectionController extends ChangeNotifier {
  String? _expandedSectionId;

  String? get expandedSectionId => _expandedSectionId;

  void expandSection(String sectionId) {
    if (_expandedSectionId == sectionId) {
      // If tapping the same section again, collapse it
      _expandedSectionId = null;
    } else {
      // Otherwise, expand this one and collapse others
      _expandedSectionId = sectionId;
    }
    notifyListeners();
  }
}

class HealthDashboard extends StatefulWidget {
  const HealthDashboard({super.key});

  @override
  State<HealthDashboard> createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  // Create a single controller to manage all sections
  final SectionController _sectionController = SectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Body Vitals Section
                    ExpandableSection(
                      id: 'body_vitals',
                      title: 'Body Vitals',
                      icon: Icons.monitor_heart,
                      controller: _sectionController,
                      children: [
                        HealthTile(
                          title: 'Body Mass Index',
                          value: '21.61',
                          subvalue: 'Normal',
                          icon: Icons.accessibility_new,
                          color: Colors.purple[400]!,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Body Surface Area',
                          value: '1.69 (m²)',
                          icon: Icons.person_outline,
                          color: Colors.purple[400]!,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Height',
                          value: '5\' 7" (ft/in)',
                          icon: Icons.height,
                          color: Colors.purple[400]!,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Weight',
                          value: '61 (kgs)',
                          icon: Icons.monitor_weight,
                          color: Colors.purple[400]!,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Sleep',
                          value: 'No data',
                          icon: Icons.bedtime,
                          color: Colors.purple[400]!,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Health Conditions Section
                    ExpandableSection(
                      id: 'health_conditions',
                      title: 'Health Conditions',
                      icon: Icons.favorite_border,
                      controller: _sectionController,
                      children: [
                        HealthTile(
                          title: 'Health Conditions',
                          value: 'No data',
                          icon: Icons.favorite,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Symptoms',
                          value: 'No data',
                          icon: Icons.healing,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        HealthTile(
                          title: 'Family History of Diabetes',
                          value: '-ve',
                          icon: Icons.family_restroom,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Meals Section
                    ExpandableSection(
                      id: 'meals',
                      title: 'Meals',
                      icon: Icons.restaurant_menu,
                      controller: _sectionController,
                      children: [
                        HealthTile(
                          title: 'Meals',
                          value: 'High carb meals 65/0',
                          subvalue: 'Above 0 Cal',
                          secondValue: 'Test Result:',
                          secondSubvalue: 'No data',
                          icon: Icons.restaurant,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Activities Section
                    ExpandableSection(
                      id: 'activities',
                      title: 'Activities',
                      icon: Icons.fitness_center,
                      controller: _sectionController,
                      children: [
                        HealthTile(
                          title: 'Physical Activity',
                          value: 'Submitted:',
                          subvalue: 'NA',
                          secondValue: 'Test Result:',
                          secondSubvalue: 'No data',
                          icon: Icons.directions_run,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // More Details Text outside the main container
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(),
                    ),
                  );
                },
                child: Text(
                  'More Details',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Glucose Statistics Section
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // First Section: Glucose Exposure
                    const GlucoseExposureSection(),
                    const SizedBox(height: 16),

                    // Second Section: Glucose Ranges
                    const GlucoseRangesSection(),
                    const SizedBox(height: 16),

                    // Third Section: Glucose Variability
                    const GlucoseVariabilitySection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    // Set the preferred orientations to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset the preferred orientations to portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the Column in a SingleChildScrollView
        child: Column(
          children: [
            // Container for AGPChartScreen with increased height
            SizedBox(
              height: 600, // Height for the chart
              child: const AGPChartScreen(), // Your chart widget
            ),
/*
            // Container for HealthMetricsDashboard with specified height
            SizedBox(
              height: 400, // Set a height for the dashboard
              child: const HealthMetricsDashboard(), // Your dashboard widget
            ),*/
          ],
        ),
      ),
    );
  }
}

class GlucoseVariabilitySection extends StatelessWidget {
  const GlucoseVariabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlucoseCard(
                title1: 'Coefficient of',
                title2: 'Variation',
                value: '38.5%',
                footnote: '< 36% *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlucoseCard(
                title1: 'Standard',
                title2: 'Deviation',
                value: '47',
                footnote: '< 40 *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Variability'),
      ],
    );
  }
}

// Expandable Section Widget
class ExpandableSection extends StatefulWidget {
  final String id; // Unique identifier for each section
  final String title;
  final IconData icon;
  final List<Widget> children;
  final SectionController controller;

  const ExpandableSection({
    super.key,
    required this.id,
    required this.title,
    required this.icon,
    required this.children,
    required this.controller,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Listen to the controller for changes
    widget.controller.addListener(_updateExpandedState);
  }

  @override
  void dispose() {
    // Remove listener when the widget is disposed
    widget.controller.removeListener(_updateExpandedState);
    super.dispose();
  }

  // Update local expanded state based on controller
  void _updateExpandedState() {
    final newExpandedState = widget.controller.expandedSectionId == widget.id;
    if (newExpandedState != _isExpanded) {
      setState(() {
        _isExpanded = newExpandedState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with toggle
        InkWell(
          onTap: () {
            // Notify the controller that this section was tapped
            widget.controller.expandSection(widget.id);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withAlpha(77),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        // Expandable content
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? null : 0,
          child: AnimatedOpacity(
            opacity: _isExpanded ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: _isExpanded ? widget.children : [],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Health Tile Widget
class HealthTile extends StatelessWidget {
  final String title;
  final String value;
  final String? subvalue;
  final String? secondValue;
  final String? secondSubvalue;
  final IconData icon;
  final Color color;

  const HealthTile({
    super.key,
    required this.title,
    required this.value,
    this.subvalue,
    this.secondValue,
    this.secondSubvalue,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tile header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tile content
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: value == 'No data'
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                if (subvalue != null)
                  Text(
                    subvalue!,
                    style: TextStyle(
                      fontSize: 14,
                      color: subvalue == 'Normal'
                          ? Colors.orange
                          : Colors.grey[700],
                    ),
                  ),
                if (secondValue != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    secondValue!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  if (secondSubvalue != null)
                    Text(
                      secondSubvalue!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// First Section - Glucose Exposure (Top Cards)
class GlucoseExposureSection extends StatelessWidget {
  const GlucoseExposureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlucoseCard(
                title1: 'Avg Glucose',
                title2: 'mg/dL',
                value: '122',
                footnote: '88 - 116 *',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GlucoseCard(
                title1: 'Glycemic',
                title2: 'Estimate',
                value: '5.8',
                footnote: '< 6*',
                valueColor: Colors.orange,
                backgroundColor: const Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Exposure'),
      ],
    );
  }
}

/// Second Section - Glucose Ranges (Middle Card)
class GlucoseRangesSection extends StatelessWidget {
  const GlucoseRangesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlucoseRangesCard(
          ranges: [
            GlucoseRange('Below 54 mg/dL', '1.49%'),
            GlucoseRange('Below 70 mg/dL', '8.81%'),
            GlucoseRange('In Target 70 to 180 mg/dL', '78.94%'),
            GlucoseRange('Above 180 mg/dL', '8.66%'),
            GlucoseRange('Above 250 mg/dL', '2.09%'),
          ],
        ),
        const SizedBox(height: 8),
        SectionLabel(text: 'Glucose Ranges'),
      ],
    );
  }
}

/// Glucose Card Widget (Used in Multiple Sections)
class GlucoseCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String value;
  final String footnote;
  final Color valueColor;
  final Color backgroundColor;

  const GlucoseCard({
    super.key,
    required this.title1,
    required this.title2,
    required this.value,
    required this.footnote,
    required this.valueColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: backgroundColor,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  footnote,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Glucose Ranges Widget
class GlucoseRangesCard extends StatelessWidget {
  final List<GlucoseRange> ranges;

  const GlucoseRangesCard({super.key, required this.ranges});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: ranges.map((range) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child:
                        Text(range.label, style: const TextStyle(fontSize: 14)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('.....................',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Text(range.value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Simple Section Label Widget
class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold),
    );
  }
}

class GlucoseRange {
  final String label;
  final String value;

  GlucoseRange(this.label, this.value);
}
