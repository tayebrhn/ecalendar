import 'package:flutter/material.dart';

class CalendarColorScheme {
  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEADDFF),
    onPrimaryContainer: Color(0xFF21005D),
    secondary: Color(0xFF625B71),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE8DEF8),
    onSecondaryContainer: Color(0xFF1D192B),
    tertiary: Color(0xFF7D5260),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFD8E4),
    onTertiaryContainer: Color(0xFF31111D),
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFF9DEDC),
    onErrorContainer: Color(0xFF410E0B),
    surface: Color(0xFFFFFBFE),
    onSurface: Color(0xFF1C1B1F),
    surfaceContainerHighest: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),
    outline: Color(0xFF79747E),
  );

  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFD0BCFF),
    onPrimary: Color(0xFF381E72),
    primaryContainer: Color(0xFF4F378B),
    onPrimaryContainer: Color(0xFFEADDFF),
    secondary: Color(0xFFCCC2DC),
    onSecondary: Color(0xFF332D41),
    secondaryContainer: Color(0xFF4A4458),
    onSecondaryContainer: Color(0xFFE8DEF8),
    tertiary: Color(0xFFEFB8C8),
    onTertiary: Color(0xFF492532),
    tertiaryContainer: Color(0xFF633B48),
    onTertiaryContainer: Color(0xFFFFD8E4),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFF9DEDC),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFE6E1E5),
    surfaceContainerHighest: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: Color(0xFF938F99),
  );

  // Get the appropriate color scheme based on brightness
  static ColorScheme getColorScheme(bool isDarkMode) {
    return isDarkMode ? darkColorScheme : lightColorScheme;
  }
}

// Custom calendar theme data extending ThemeExtension
class CalendarThemeData extends ThemeExtension<CalendarThemeData> {
  final Color eventIndicatorColor;
  final Color todayHighlightColor;
  final Color selectedDayColor;
  final Color selectedDayTextColor;
  final Color weekendDayTextColor;
  final Color disabledDayTextColor;
  final Color rangeSelectionColor;
  final Color rangeSelectionEdgeColor;
  final Color headerBackgroundColor;
  final Color headerTextColor;
  final Color weekdayTextColor;

  const CalendarThemeData({
    required this.eventIndicatorColor,
    required this.todayHighlightColor,
    required this.selectedDayColor,
    required this.selectedDayTextColor,
    required this.weekendDayTextColor,
    required this.disabledDayTextColor,
    required this.rangeSelectionColor,
    required this.rangeSelectionEdgeColor,
    required this.headerBackgroundColor,
    required this.headerTextColor,
    required this.weekdayTextColor,
  });

  @override
  ThemeExtension<CalendarThemeData> copyWith({
    Color? eventIndicatorColor,
    Color? todayHighlightColor,
    Color? selectedDayColor,
    Color? selectedDayTextColor,
    Color? weekendDayTextColor,
    Color? disabledDayTextColor,
    Color? rangeSelectionColor,
    Color? rangeSelectionEdgeColor,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    Color? weekdayTextColor,
  }) {
    return CalendarThemeData(
      eventIndicatorColor: eventIndicatorColor ?? this.eventIndicatorColor,
      todayHighlightColor: todayHighlightColor ?? this.todayHighlightColor,
      selectedDayColor: selectedDayColor ?? this.selectedDayColor,
      selectedDayTextColor: selectedDayTextColor ?? this.selectedDayTextColor,
      weekendDayTextColor: weekendDayTextColor ?? this.weekendDayTextColor,
      disabledDayTextColor: disabledDayTextColor ?? this.disabledDayTextColor,
      rangeSelectionColor: rangeSelectionColor ?? this.rangeSelectionColor,
      rangeSelectionEdgeColor:
          rangeSelectionEdgeColor ?? this.rangeSelectionEdgeColor,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      weekdayTextColor: weekdayTextColor ?? this.weekdayTextColor,
    );
  }

  @override
  ThemeExtension<CalendarThemeData> lerp(
    ThemeExtension<CalendarThemeData>? other,
    double t,
  ) {
    if (other is! CalendarThemeData) {
      return this;
    }
    return CalendarThemeData(
      eventIndicatorColor:
          Color.lerp(eventIndicatorColor, other.eventIndicatorColor, t)!,
      todayHighlightColor:
          Color.lerp(todayHighlightColor, other.todayHighlightColor, t)!,
      selectedDayColor:
          Color.lerp(selectedDayColor, other.selectedDayColor, t)!,
      selectedDayTextColor:
          Color.lerp(selectedDayTextColor, other.selectedDayTextColor, t)!,
      weekendDayTextColor:
          Color.lerp(weekendDayTextColor, other.weekendDayTextColor, t)!,
      disabledDayTextColor:
          Color.lerp(disabledDayTextColor, other.disabledDayTextColor, t)!,
      rangeSelectionColor:
          Color.lerp(rangeSelectionColor, other.rangeSelectionColor, t)!,
      rangeSelectionEdgeColor:
          Color.lerp(
            rangeSelectionEdgeColor,
            other.rangeSelectionEdgeColor,
            t,
          )!,
      headerBackgroundColor:
          Color.lerp(headerBackgroundColor, other.headerBackgroundColor, t)!,
      headerTextColor: Color.lerp(headerTextColor, other.headerTextColor, t)!,
      weekdayTextColor:
          Color.lerp(weekdayTextColor, other.weekdayTextColor, t)!,
    );
  }

  // Light theme
  static const CalendarThemeData light = CalendarThemeData(
    eventIndicatorColor: Color(0xFF6750A4),
    todayHighlightColor: Color(0xFFEADDFF),
    selectedDayColor: Color(0xFF6750A4),
    selectedDayTextColor: Color(0xFFFFFFFF),
    weekendDayTextColor: Color(0xFF625B71),
    disabledDayTextColor: Color(0xFFC9C5CA),
    rangeSelectionColor: Color(0x336750A4),
    rangeSelectionEdgeColor: Color(0xFF6750A4),
    headerBackgroundColor: Color(0xFFE7E0EC),
    headerTextColor: Color(0xFF49454F),
    weekdayTextColor: Color(0xFF625B71),
  );

  // Dark theme
  static const CalendarThemeData dark = CalendarThemeData(
    eventIndicatorColor: Color(0xFFD0BCFF),
    todayHighlightColor: Color(0xFF4F378B),
    selectedDayColor: Color(0xFFD0BCFF),
    selectedDayTextColor: Color(0xFF381E72),
    weekendDayTextColor: Color(0xFFCCC2DC),
    disabledDayTextColor: Color(0xFF938F99),
    rangeSelectionColor: Color(0x334F378B),
    rangeSelectionEdgeColor: Color(0xFFD0BCFF),
    headerBackgroundColor: Color(0xFF49454F),
    headerTextColor: Color(0xFFCAC4D0),
    weekdayTextColor: Color(0xFFCCC2DC),
  );
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  primaryColor: Colors.black87,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  primaryColor: Colors.white,
);
