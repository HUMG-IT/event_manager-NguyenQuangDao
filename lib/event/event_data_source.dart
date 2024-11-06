import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event_model.dart';

class EventDataSouce extends CalendarDataSource {
  EventDataSouce(List<EventModel> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.startTime;
  }

  @override
  DateTime getEndTime(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.endTime;
  }

  @override
  String getSubject(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.subject;
  }

  @override
  String? getNotes(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.notes;
  }

  @override
  bool isAllDay(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.isAllDay;
  }

  @override
  String? getRecurrenceRule(int index) {
    EventModel item = appointments!.elementAt(index);
    return item.recurrenceRule;
  }

  @override
  Color getColor(int index) {
    EventModel item = appointments!.elementAt(index);
    // Đặt màu sắc dựa trên giá trị rating
    if (item.rating != null) {
      return getRatingColor(item.rating as double);
    } else if (item.isAllDay) {
      return const Color(0xFF2FBB6E);
    }

    return super.getColor(index);
  }

  Color getRatingColor(double rating) {
    switch (rating) {
      case 1:
        return const Color.fromARGB(255, 7, 178, 13); // Rất dễ
      case 2:
        return const Color.fromARGB(255, 134, 187, 80); // Dễ
      case 3:
        return Colors.amber; // Trung bình
      case 4:
        return const Color.fromARGB(255, 244, 105, 105); // Khó
      case 5:
        return const Color.fromARGB(255, 239, 22, 6); // Rất khó
      default:
        return Colors.grey; // Màu mặc định nếu rating không hợp lệ
    }
  }
}
