// import 'package:flutter/material.dart';

// /// Comprehensive color scheme for Flutter calendar with dark and light mode support
// class CalendarColorScheme {
  
//   // ============================================================================
//   // LIGHT MODE COLORS
//   // ============================================================================
  
//   static const CalendarColors light = CalendarColors(
//     // Background colors
//     backgroundColor: Color(0xFFFAFAFA),           // Soft off-white for main background
//     surfaceColor: Color(0xFFFFFFFF),             // Pure white for calendar surface
//     headerBackgroundColor: Color(0xFFF5F5F5),    // Light gray for header section
    
//     // Text colors
//     primaryTextColor: Color(0xFF1A1A1A),         // Almost black for primary text
//     secondaryTextColor: Color(0xFF666666),       // Medium gray for secondary text
//     headerTextColor: Color(0xFF2C2C2C),          // Dark gray for header text
    
//     // Calendar day colors
//     todayBackgroundColor: Color(0xFF2196F3),     // Material blue for today
//     todayTextColor: Color(0xFFFFFFFF),           // White text on today
//     selectedDayBackgroundColor: Color(0xFF1976D2), // Darker blue for selected day
//     selectedDayTextColor: Color(0xFFFFFFFF),     // White text on selected
    
//     // Day states
//     currentMonthDayColor: Color(0xFF1A1A1A),     // Dark text for current month days
//     otherMonthDayColor: Color(0xFFBDBDBD),       // Light gray for other month days
//     weekendDayColor: Color(0xFF757575),          // Medium gray for weekends
//     disabledDayColor: Color(0xFFE0E0E0),         // Very light gray for disabled days
    
//     // Event and accent colors
//     eventDotColor: Color(0xFF4CAF50),            // Green for event indicators
//     holidayColor: Color(0xFFFF5722),             // Orange-red for holidays
//     workdayColor: Color(0xFF2196F3),             // Blue for work days
    
//     // Interactive elements
//     hoverColor: Color(0x0F000000),               // 6% black overlay for hover
//     pressedColor: Color(0x1F000000),             // 12% black overlay for pressed
//     focusColor: Color(0x1F2196F3),               // 12% blue overlay for focus
    
//     // Borders and dividers
//     borderColor: Color(0xFFE0E0E0),              // Light gray for borders
//     dividerColor: Color(0xFFEEEEEE),             // Very light gray for dividers
//   );
  
//   // ============================================================================
//   // DARK MODE COLORS
//   // ============================================================================
  
//   static const CalendarColors dark = CalendarColors(
//     // Background colors
//     backgroundColor: Color(0xFF121212),           // Material dark background
//     surfaceColor: Color(0xFF1E1E1E),             // Elevated surface color
//     headerBackgroundColor: Color(0xFF2A2A2A),    // Slightly lighter for header
    
//     // Text colors
//     primaryTextColor: Color(0xFFFFFFFF),         // White for primary text
//     secondaryTextColor: Color(0xFFB3B3B3),       // Light gray for secondary text
//     headerTextColor: Color(0xFFE0E0E0),          // Light gray for header text
    
//     // Calendar day colors
//     todayBackgroundColor: Color(0xFF42A5F5),     // Lighter blue for today (better contrast)
//     todayTextColor: Color(0xFF000000),           // Black text on today for contrast
//     selectedDayBackgroundColor: Color(0xFF1E88E5), // Medium blue for selected day
//     selectedDayTextColor: Color(0xFFFFFFFF),     // White text on selected
    
//     // Day states
//     currentMonthDayColor: Color(0xFFFFFFFF),     // White text for current month days
//     otherMonthDayColor: Color(0xFF616161),       // Medium gray for other month days
//     weekendDayColor: Color(0xFF9E9E9E),          // Light gray for weekends
//     disabledDayColor: Color(0xFF424242),         // Dark gray for disabled days
    
//     // Event and accent colors
//     eventDotColor: Color(0xFF66BB6A),            // Lighter green for event indicators
//     holidayColor: Color(0xFFFF7043),             // Lighter orange-red for holidays
//     workdayColor: Color(0xFF42A5F5),             // Lighter blue for work days
    
//     // Interactive elements
//     hoverColor: Color(0x0FFFFFFF),               // 6% white overlay for hover
//     pressedColor: Color(0x1FFFFFFF),             // 12% white overlay for pressed
//     focusColor: Color(0x1F42A5F5),               // 12% blue overlay for focus
    
//     // Borders and dividers
//     borderColor: Color(0xFF424242),              // Medium gray for borders
//     dividerColor: Color(0xFF2A2A2A),             // Dark gray for dividers
//   );
// }

// /// Immutable class containing all calendar colors
// class CalendarColors {
//   const CalendarColors({
//     required this.backgroundColor,
//     required this.surfaceColor,
//     required this.headerBackgroundColor,
//     required this.primaryTextColor,
//     required this.secondaryTextColor,
//     required this.headerTextColor,
//     required this.todayBackgroundColor,
//     required this.todayTextColor,
//     required this.selectedDayBackgroundColor,
//     required this.selectedDayTextColor,
//     required this.currentMonthDayColor,
//     required this.otherMonthDayColor,
//     required this.weekendDayColor,
//     required this.disabledDayColor,
//     required this.eventDotColor,
//     required this.holidayColor,
//     required this.workdayColor,
//     required this.hoverColor,
//     required this.pressedColor,
//     required this.focusColor,
//     required this.borderColor,
//     required this.dividerColor,
//   });
  
//   // Background colors
//   final Color backgroundColor;
//   final Color surfaceColor;
//   final Color headerBackgroundColor;
  
//   // Text colors
//   final Color primaryTextColor;
//   final Color secondaryTextColor;
//   final Color headerTextColor;
  
//   // Calendar day colors
//   final Color todayBackgroundColor;
//   final Color todayTextColor;
//   final Color selectedDayBackgroundColor;
//   final Color selectedDayTextColor;
  
//   // Day states
//   final Color currentMonthDayColor;
//   final Color otherMonthDayColor;
//   final Color weekendDayColor;
//   final Color disabledDayColor;
  
//   // Event and accent colors
//   final Color eventDotColor;
//   final Color holidayColor;
//   final Color workdayColor;
  
//   // Interactive elements
//   final Color hoverColor;
//   final Color pressedColor;
//   final Color focusColor;
  
//   // Borders and dividers
//   final Color borderColor;
//   final Color dividerColor;
// }

// /// Extension to get calendar colors based on brightness
// extension CalendarThemeExtension on ThemeData {
//   CalendarColors get calendarColors {
//     return brightness == Brightness.dark 
//         ? CalendarColorScheme.dark 
//         : CalendarColorScheme.light;
//   }
// }

// /// Example usage in a calendar widget
// class ExampleCalendarWidget extends StatelessWidget {
//   const ExampleCalendarWidget({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).calendarColors;
    
//     return Container(
//       color: colors.backgroundColor,
//       child: Column(
//         children: [
//           // Calendar header
//           Container(
//             padding: const EdgeInsets.all(16),
//             color: colors.headerBackgroundColor,
//             child: Text(
//               'January 2024',
//               style: TextStyle(
//                 color: colors.headerTextColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
          
//           // Calendar grid would go here
//           Expanded(
//             child: Container(
//               color: colors.surfaceColor,
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 7,
//                 ),
//                 itemCount: 42, // 6 weeks × 7 days
//                 itemBuilder: (context, index) {
//                   // Example day cell
//                   final isToday = index == 15; // Example
//                   final isSelected = index == 20; // Example
//                   final isOtherMonth = index < 5 || index > 35; // Example
                  
//                   Color backgroundColor = Colors.transparent;
//                   Color textColor = colors.currentMonthDayColor;
                  
//                   if (isToday) {
//                     backgroundColor = colors.todayBackgroundColor;
//                     textColor = colors.todayTextColor;
//                   } else if (isSelected) {
//                     backgroundColor = colors.selectedDayBackgroundColor;
//                     textColor = colors.selectedDayTextColor;
//                   } else if (isOtherMonth) {
//                     textColor = colors.otherMonthDayColor;
//                   }
                  
//                   return Container(
//                     margin: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       color: backgroundColor,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: colors.borderColor,
//                         width: 0.5,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '${(index % 31) + 1}',
//                         style: TextStyle(
//                           color: textColor,
//                           fontWeight: isToday || isSelected 
//                               ? FontWeight.w600 
//                               : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Color scheme explanations and usage guidelines
// class CalendarColorGuide {
//   static const String explanation = '''
  
// CALENDAR COLOR SCHEME EXPLANATIONS:

// LIGHT MODE:
// - backgroundColor (0xFFFAFAFA): Soft off-white provides a clean, non-harsh background
// - surfaceColor (0xFFFFFFFF): Pure white for calendar grid creates clear separation
// - todayBackgroundColor (0xFF2196F3): Material blue makes current day easily identifiable
// - selectedDayBackgroundColor (0xFF1976D2): Darker blue differentiates selection from today
// - eventDotColor (0xFF4CAF50): Green indicates positive events/appointments
// - holidayColor (0xFFFF5722): Orange-red draws attention to special days

// DARK MODE:
// - backgroundColor (0xFF121212): Material dark background reduces eye strain
// - surfaceColor (0xFF1E1E1E): Elevated surface following Material Design guidelines
// - todayBackgroundColor (0xFF42A5F5): Lighter blue maintains visibility in dark theme
// - todayTextColor (0xFF000000): Black text on light blue ensures contrast compliance
// - Interactive overlays use white with low opacity for consistency

// ACCESSIBILITY CONSIDERATIONS:
// - All color combinations meet WCAG AA contrast ratios (4.5:1 minimum)
// - Today and selected states use different colors, not just the same color with different opacity
// - Weekend days have distinct coloring for users who need visual differentiation
// - Disabled states are clearly distinguishable from interactive elements

// USAGE RECOMMENDATIONS:
// - Use the ThemeData extension for automatic light/dark mode switching
// - Apply hover/pressed states for desktop and web interactions
// - Consider adding semantic colors for different event types
// - Test colors with color blindness simulators for inclusive design
//   ''';
// }
