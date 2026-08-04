# attendanceapp_flutter

Flutter assignment — an Attendance History screen built with Flutter.

## Screen

- **Top bar** — "Attendance History" title with a history icon and an overflow (more) icon.
- **Summary card** — total days present (142 in 2023), attendance percentage (94%), and change vs last month (+2%).
- **Activity grid** — weekly (Mon–Sun) grid of days marked as Present, Leave, or Off, with a legend.
- **Action button** — "Log Attendance Today".

Data shown is static sample data defined in code.

## Screenshot

<p align="center">
  <img src="screenshots/attendance_history.jpeg" alt="Attendance History screen" width="260" />
</p>

## Project structure

```
lib/
  main.dart
  screens/
    attendance_history_screen.dart
test/
  widget_test.dart
```

## Run

```bash
flutter pub get
flutter run
```

## Requirements

- Flutter SDK (Dart ^3.12.0)
