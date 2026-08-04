import 'package:flutter/material.dart';

enum DayStatus { present, leave, off }

const List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const List<List<DayStatus>> _activity = [
  [DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.off, DayStatus.off],
  [DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.off, DayStatus.off],
  [DayStatus.present, DayStatus.present, DayStatus.leave, DayStatus.present, DayStatus.present, DayStatus.off, DayStatus.off],
  [DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.present, DayStatus.off, DayStatus.off],
  [DayStatus.present, DayStatus.present, DayStatus.off, DayStatus.off, DayStatus.off, DayStatus.off, DayStatus.off],
];

class _Palette {
  static const Color background = Color(0xFFF5F7FB);
  static const Color blueStart = Color(0xFF3E6BF0);
  static const Color blueEnd = Color(0xFF1B3FC7);
  static const Color blue = Color(0xFF1B49D6);
  static const Color present = Color(0xFF1E7A3C);
  static const Color leave = Color(0xFFD7E3FB);
  static const Color off = Color(0xFFEDF1F9);
  static const Color grey = Color(0xFF8A93A6);
  static const Color dark = Color(0xFF1B1F27);
}

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Palette.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            _TopBar(),
            SizedBox(height: 20),
            _SummaryCard(),
            SizedBox(height: 28),
            _SectionHeader(),
            SizedBox(height: 12),
            _ActivityCard(),
            SizedBox(height: 28),
            _ActionsLabel(),
            SizedBox(height: 12),
            _LogAttendanceButton(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.history, color: _Palette.blue, size: 26),
        SizedBox(width: 10),
        Text(
          'Attendance History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _Palette.dark),
        ),
        Spacer(),
        Icon(Icons.more_vert, color: _Palette.dark),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_Palette.blueStart, _Palette.blueEnd],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL DAYS PRESENT',
            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('142', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w800, height: 1)),
              SizedBox(width: 8),
              Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text('days in 2023', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              _Dot(color: Color(0xFF3DDC73)),
              SizedBox(width: 6),
              Text('94% Attendance', style: TextStyle(color: Colors.white, fontSize: 13)),
              SizedBox(width: 18),
              Icon(Icons.trending_up, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text('+2% vs last month', style: TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text('Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _Palette.dark)),
        Spacer(),
        Text('2023', style: TextStyle(fontSize: 13, color: _Palette.grey)),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final day in _weekDays)
                Text(day, style: const TextStyle(fontSize: 11, color: _Palette.grey, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 10),
          for (final week in _activity) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [for (final status in week) _DaySquare(status: status)],
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 6),
          const Divider(height: 1, color: _Palette.off),
          const SizedBox(height: 14),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: _Palette.present, label: 'Present'),
              SizedBox(width: 20),
              _LegendItem(color: _Palette.leave, label: 'Leave'),
              SizedBox(width: 20),
              _LegendItem(color: _Palette.off, label: 'Off'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DaySquare extends StatelessWidget {
  const _DaySquare({required this.status});

  final DayStatus status;

  Color get _color => switch (status) {
        DayStatus.present => _Palette.present,
        DayStatus.leave => _Palette.leave,
        DayStatus.off => _Palette.off,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: _Palette.grey)),
      ],
    );
  }
}

class _ActionsLabel extends StatelessWidget {
  const _ActionsLabel();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ACTIONS',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _Palette.grey, letterSpacing: 0.6),
    );
  }
}

class _LogAttendanceButton extends StatelessWidget {
  const _LogAttendanceButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: _Palette.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        icon: const Icon(Icons.check_circle, size: 20),
        label: const Text('Log Attendance Today', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
