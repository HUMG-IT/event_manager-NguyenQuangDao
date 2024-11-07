import 'package:event_manager/event/event_chart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event_data_source.dart';
import 'event_detail_view.dart';
import 'event_model.dart';
import 'event_service.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final eventService = EventService();
  List<EventModel> items = [];
  final calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    calendarController.view = CalendarView.day;
    loadEvents();
  }

  Future<void> loadEvents() async {
    final events = await eventService.getAllEvents();
    setState(() {
      items = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(al!.appTitle),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                calendarController.view = value;
              });
            },
            itemBuilder: (context) => CalendarView.values.map((view) {
              return PopupMenuItem<CalendarView>(
                  value: view,
                  child: ListTile(
                    title: Text(view.name),
                  ));
            }).toList(),
            icon: getCalendarViewIcon(calendarController.view!),
          ),
          IconButton(
            onPressed: () {
              calendarController.displayDate = DateTime.now();
            },
            icon: const Icon(Icons.today_outlined),
          ),
          IconButton(
            onPressed: loadEvents,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventChartView()),
                );
              } else if (value == 2) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PageTwo()),
                // );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.bar_chart_outlined),
                    SizedBox(width: 8),
                    Text('Biểu đồ thống kê'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.pageview),
                    SizedBox(width: 8),
                    Text('Trang 2'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SfCalendar(
        controller: calendarController,
        view: CalendarView.month,
        timeZone: 'SE Asia Standard Time',
        dataSource: EventDataSouce(items),
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        // nhấn giữ cell để thêm sự kiện
        onLongPress: (details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            final newEvent = EventModel(
              startTime: details.date!,
              endTime: details.date!.add(const Duration(hours: 1)),
              subject: 'Sự kiện mới',
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EventDetailView(event: newEvent);
              },
            )).then((value) async {
              if (value == true) {
                await loadEvents();
              }
            });
          }
        },
        onTap: (details) {
          if (details.targetElement == CalendarElement.appointment) {
            final EventModel event = details.appointments!.first;
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EventDetailView(event: event);
              },
            )).then((value) async {
              if (value == true) {
                await loadEvents();
              }
            });
          }
        },
      ),
    );
  }

  Icon getCalendarViewIcon(CalendarView view) {
    switch (view) {
      case CalendarView.day:
        return const Icon(Icons.calendar_view_day_outlined);
      case CalendarView.week:
        return const Icon(Icons.view_week_outlined);
      case CalendarView.workWeek:
        return const Icon(Icons.work_outline);
      case CalendarView.month:
        return const Icon(Icons.calendar_month_outlined);
      case CalendarView.timelineDay:
        return const Icon(Icons.timeline);
      case CalendarView.timelineWeek:
        return const Icon(Icons.view_timeline_outlined);
      case CalendarView.timelineWorkWeek:
        return const Icon(Icons.work_history_outlined);
      case CalendarView.timelineMonth:
        return const Icon(Icons.date_range_outlined);
      case CalendarView.schedule:
        return const Icon(Icons.schedule_outlined);
    }
  }
}
