import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeZoneClockCard extends StatelessWidget {
  final String timezone;
  final String time;
  final String date;

  const TimeZoneClockCard({
    super.key,
    required this.timezone,
    required this.time,
    required this.date,
  });

  String _getDisplayName(String timezone) {
    final parts = timezone.split('/');
    if (parts.length == 2) {
      return parts[1].replaceAll('_', ' ');
    }
    return timezone;
  }

  Color _getColorByTimezone(String timezone) {
    const colors = [
      Color(0xFFFF6B6B),
      Color(0xFF4ECDC4),
      Color(0xFF45B7D1),
      Color(0xFFFFA07A),
      Color(0xFF98D8C8),
      Color(0xFFF7DC6F),
    ];

    final index = timezone.hashCode % colors.length;
    return colors[index < 0 ? -index : index];
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _getDisplayName(timezone);
    final cardColor = _getColorByTimezone(timezone);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cardColor,
            cardColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
