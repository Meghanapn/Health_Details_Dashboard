import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGP Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AGPChartScreen(),
    );
  }
}

class AGPChartScreen extends StatelessWidget {
  const AGPChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AGP for 15 days'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
          child: LayoutBuilder(builder: (context, constraints) {
            // Define a minimum chart width that's larger than the screen
            // to enable scrolling
            final chartWidth = max(constraints.maxWidth * 1.5, 600.0);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: chartWidth,
                      child: AGPChart(chartWidth: chartWidth),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: chartWidth,
                      child: _buildStepCountRow(chartWidth, isSmallScreen),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text('( Number of steps )'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStepCountRow(double availableWidth, bool isSmallScreen) {
    final stepCounts = [
      "0",
      "0",
      "0",
      "0",
      "120",
      "320",
      "600",
      "500",
      "130",
      "160",
      "0",
      "0"
    ];
    final itemWidth = availableWidth / stepCounts.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stepCounts
          .map((count) => SizedBox(
                width: itemWidth,
                child: Text(
                  count,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: isSmallScreen ? 10 : 12),
                ),
              ))
          .toList(),
    );
  }
}

class StepCountBox extends StatelessWidget {
  final String count;
  final double width;

  const StepCountBox(this.count, {this.width = 30, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        count,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

class AGPChart extends StatelessWidget {
  final double chartWidth;

  AGPChart({required this.chartWidth, super.key});

  // Sample data for median glucose line
  final List<FlSpot> medianLine = [
    const FlSpot(0, 110),
    const FlSpot(2, 100),
    const FlSpot(4, 90),
    const FlSpot(6, 80),
    const FlSpot(8, 85),
    const FlSpot(10, 150),
    const FlSpot(12, 100),
    const FlSpot(14, 120),
    const FlSpot(16, 130),
    const FlSpot(18, 120),
    const FlSpot(20, 150),
    const FlSpot(22, 160),
    const FlSpot(24, 150)
  ];

  // Data for percentile ranges
  final List<FlSpot> upperIQR = [
    const FlSpot(0, 170),
    const FlSpot(2, 140),
    const FlSpot(4, 130),
    const FlSpot(6, 120),
    const FlSpot(8, 130),
    const FlSpot(10, 180),
    const FlSpot(12, 160),
    const FlSpot(14, 160),
    const FlSpot(16, 170),
    const FlSpot(18, 170),
    const FlSpot(20, 190),
    const FlSpot(22, 190),
    const FlSpot(24, 200)
  ];

  final List<FlSpot> lowerIQR = [
    const FlSpot(0, 90),
    const FlSpot(2, 80),
    const FlSpot(4, 70),
    const FlSpot(6, 60),
    const FlSpot(8, 70),
    const FlSpot(10, 120),
    const FlSpot(12, 70),
    const FlSpot(14, 90),
    const FlSpot(16, 100),
    const FlSpot(18, 90),
    const FlSpot(20, 120),
    const FlSpot(22, 120),
    const FlSpot(24, 110)
  ];

  final List<FlSpot> upper10_90 = [
    const FlSpot(0, 200),
    const FlSpot(2, 170),
    const FlSpot(4, 160),
    const FlSpot(6, 140),
    const FlSpot(8, 150),
    const FlSpot(10, 200),
    const FlSpot(12, 180),
    const FlSpot(14, 200),
    const FlSpot(16, 200),
    const FlSpot(18, 200),
    const FlSpot(20, 220),
    const FlSpot(22, 220),
    const FlSpot(24, 210)
  ];

  final List<FlSpot> lower10_90 = [
    const FlSpot(0, 70),
    const FlSpot(2, 60),
    const FlSpot(4, 50),
    const FlSpot(6, 40),
    const FlSpot(8, 50),
    const FlSpot(10, 80),
    const FlSpot(12, 50),
    const FlSpot(14, 70),
    const FlSpot(16, 80),
    const FlSpot(18, 70),
    const FlSpot(20, 90),
    const FlSpot(22, 90),
    const FlSpot(24, 80)
  ];

  // Step data for bar chart
  final List<BarChartGroupData> stepsData = [
    BarChartGroupData(
        x: 0, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 2, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 4, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 6, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 8, barRods: [BarChartRodData(toY: 120, color: Colors.orange)]),
    BarChartGroupData(
        x: 10, barRods: [BarChartRodData(toY: 320, color: Colors.orange)]),
    BarChartGroupData(
        x: 12, barRods: [BarChartRodData(toY: 600, color: Colors.orange)]),
    BarChartGroupData(
        x: 14, barRods: [BarChartRodData(toY: 500, color: Colors.orange)]),
    BarChartGroupData(
        x: 16, barRods: [BarChartRodData(toY: 130, color: Colors.orange)]),
    BarChartGroupData(
        x: 18, barRods: [BarChartRodData(toY: 160, color: Colors.orange)]),
    BarChartGroupData(
        x: 20, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 22, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
    BarChartGroupData(
        x: 24, barRods: [BarChartRodData(toY: 0, color: Colors.orange)]),
  ];

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final yAxisWidth = isSmallScreen ? 25.0 : 40.0;
    final fontSize = isSmallScreen ? 8.0 : 10.0;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Y-axis labels (left - glucose)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: _buildGlucoseYAxis(fontSize),
                ),

                // Y-axis labels (right - calories)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: _buildCaloriesYAxis(fontSize),
                ),

                // Main chart area
                Padding(
                  padding: EdgeInsets.only(left: yAxisWidth, right: yAxisWidth),
                  child: ClipRect(
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: TargetRangePainter(),
                      child: CombinedChart(
                        medianLine: medianLine,
                        upperIQR: upperIQR,
                        lowerIQR: lowerIQR,
                        upper10_90: upper10_90,
                        lower10_90: lower10_90,
                        stepsData: stepsData,
                        fontSize: fontSize,
                        showBottomTitles: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Add hour labels below the chart
          SizedBox(height: 10),
          _buildHourLabelsRow(fontSize),

          // "Time (hour)" label on x-axis
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Time (hour)',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      );
    });
  }

  // Custom widget to display hour labels below the chart
  Widget _buildHourLabelsRow(double fontSize) {
    final hours = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: hours.map((hour) {
          String text;
          if (hour == 0 || hour == 12 || hour == 24) {
            text = '12';
          } else if (hour < 12) {
            text = '$hour';
          } else if (hour > 12 && hour < 24) {
            text = '${hour - 12}';
          } else {
            text = '';
          }

          return Text(
            text,
            style: TextStyle(fontSize: fontSize),
          );
        }).toList(),
      ),
    );
  }

  // Custom glucose y-axis (left side)
  Widget _buildGlucoseYAxis(double fontSize) {
    final values = [400, 350, 300, 250, 200, 150, 100, 50, 0];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: values
          .map((value) => Text(value.toString(),
              style: TextStyle(fontSize: fontSize, color: Colors.black)))
          .toList(),
    );
  }

  // Custom calories y-axis (right side)
  Widget _buildCaloriesYAxis(double fontSize) {
    final values = [800, 700, 600, 500, 400, 300, 200, 100, 0];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: values
          .map((value) => Text(value.toString(),
              style: TextStyle(fontSize: fontSize, color: Colors.black)))
          .toList(),
    );
  }
}

// Custom painter for the target range band
class TargetRangePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    // Draw the target range band (70-180 mg/dL)
    final targetRangeRect = Rect.fromLTWH(
      0,
      size.height * 0.25, // Position to match the target range
      size.width,
      size.height * 0.2, // Height of the band
    );
    canvas.drawRect(targetRangeRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CombinedChart extends StatelessWidget {
  final List<FlSpot> medianLine;
  final List<FlSpot> upperIQR;
  final List<FlSpot> lowerIQR;
  final List<FlSpot> upper10_90;
  final List<FlSpot> lower10_90;
  final List<BarChartGroupData> stepsData;
  final double fontSize;
  final bool showBottomTitles;

  const CombinedChart({
    super.key,
    required this.medianLine,
    required this.upperIQR,
    required this.lowerIQR,
    required this.upper10_90,
    required this.lower10_90,
    required this.stepsData,
    this.fontSize = 10.0,
    this.showBottomTitles = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Line Chart (Background)
        LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              horizontalInterval: 50,
              verticalInterval: 2,
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                  reservedSize: 30,
                ),
              ),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: showBottomTitles,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final style = TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: fontSize,
                    );

                    String text;
                    if (value % 2 == 0) {
                      if (value == 0 || value == 12 || value == 24) {
                        text = '12';
                      } else if (value < 12) {
                        text = '${value.toInt()}';
                      } else if (value > 12 && value < 24) {
                        text = '${(value - 12).toInt()}';
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const SizedBox.shrink();
                    }

                    return Center(child: Text(text, style: style));
                  },
                  reservedSize: 30,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            minX: 0,
            maxX: 24,
            minY: 0,
            maxY: 400,
            lineBarsData: [
              // 10-90 percentile range (outer light purple)
              LineChartBarData(
                spots: upper10_90,
                isCurved: true,
                color: Colors.transparent,
                barWidth: 0,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.purple.withOpacity(0.2),
                ),
              ),
              LineChartBarData(
                spots: lower10_90,
                isCurved: true,
                color: Colors.transparent,
                barWidth: 0,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                aboveBarData: BarAreaData(
                  show: true,
                  color: Colors.purple.withOpacity(0.2),
                ),
              ),

              // IQR range (inner blue)
              LineChartBarData(
                spots: upperIQR,
                isCurved: true,
                color: Colors.transparent,
                barWidth: 0,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
              LineChartBarData(
                spots: lowerIQR,
                isCurved: true,
                color: Colors.transparent,
                barWidth: 0,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                aboveBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),

              // Median line
              LineChartBarData(
                spots: medianLine,
                isCurved: true,
                color: Colors.black,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),

        // Bar Chart (Foreground)
        BarChart(
          BarChartData(
            maxY: 700,
            barGroups: stepsData.map((group) {
              return BarChartGroupData(
                x: group.x,
                barRods: [
                  BarChartRodData(
                    toY: group.barRods[0].toY,
                    color: Colors.orange,
                    width: MediaQuery.of(context).size.width < 360 ? 6 : 8,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.white10.withOpacity(0.1),
                    ),
                  ),
                ],
                showingTooltipIndicators: group.barRods[0].toY > 0 ? [0] : [],
              );
            }).toList(),

            // Customize tooltip to show step count
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBorder: BorderSide.none,
                tooltipRoundedRadius: 4,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    rod.toY.toInt() > 0 ? rod.toY.toInt().toString() : '',
                    TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  );
                },
              ),
            ),

            // Hide unnecessary axes
            titlesData: FlTitlesData(
              show: false,
              bottomTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),

            // Grid configuration
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              horizontalInterval: 100,
              verticalInterval: 2,
            ),
          ),
        ),
      ],
    );
  }
}
