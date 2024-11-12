import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/rating_bar.dart';
import 'event_ notification_helper.dart';
import 'event_model.dart';
import 'event_service.dart';

// ignore: must_be_immutable
class EventDetailView extends StatefulWidget {
  EventModel event;
  EventDetailView({super.key, required this.event});

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  final subjectControler = TextEditingController();
  final notesControler = TextEditingController();
  final eventService = EventService();
  double _rating = 3.0; // Giá trị mặc định
  @override
  void initState() {
    super.initState();
    subjectControler.text = widget.event.subject;
    notesControler.text = widget.event.notes ?? '';
    _rating = widget.event.rating ?? 3.0;
  }

  Future<void> _pickDateTime({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? widget.event.startTime : widget.event.endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (!mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          isStart ? widget.event.startTime : widget.event.endTime,
        ),
      );
      if (pickedTime != null) {
        setState(() {
          final newDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStart) {
            widget.event.startTime = newDateTime;
            if (widget.event.startTime.isAfter(widget.event.endTime)) {
              // tự thiết lập end time 1 tiếng sau start time
              widget.event.endTime =
                  widget.event.startTime.add(const Duration(hours: 1));
            }
          } else {
            widget.event.endTime = newDateTime;
          }
        });
      }
    }
  }

  Future<void> _saveEvent() async {
    widget.event.subject = subjectControler.text;
    widget.event.notes = notesControler.text;
    widget.event.rating = _rating;
    await eventService.saveEvent(widget.event);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _deleteEvent() async {
    await eventService.deleteEvent(widget.event);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  Future<void> _notificationEvent() async {
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int notificationTime =
        widget.event.startTime.millisecondsSinceEpoch ~/ 1000;
    int delayInSeconds = notificationTime - currentTime;

    if (delayInSeconds > 0) {
      print("Notification will be triggered in $delayInSeconds seconds.");
      await NotificationHelper.scheduleNotification(
        widget.event.subject,
        widget.event.notes ?? '',
        delayInSeconds,
      );
    } else {
      // Hiển thị AlertDialog nếu thời gian sự kiện đã qua
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lưu ý"),
            content: const Text(
                "Thời gian sự kiện đã qua. Không thể đặt thông báo."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.id == null ? al.addEvent : al.eventDetail),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: subjectControler,
                decoration: const InputDecoration(labelText: 'Tên sự kiện'),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('sự kiện cả ngày'),
                trailing: Switch(
                    value: widget.event.isAllDay,
                    onChanged: (value) {
                      setState(() {
                        widget.event.isAllDay = value;
                      });
                    }),
              ),
              if (!widget.event.isAllDay) ...[
                const SizedBox(height: 16),
                ListTile(
                  title:
                      Text('Bắt đầu: ${widget.event.formatedStartTimeString}'),
                  trailing: const Icon(Icons.today_outlined),
                  onTap: () => _pickDateTime(isStart: true),
                ),
                // const SizedBox(height: 16),
                ListTile(
                  title:
                      Text('Kết thúc: ${widget.event.formatedEndTimeString}'),
                  trailing: const Icon(Icons.today_outlined),
                  onTap: () => _pickDateTime(isStart: false),
                ),
                TextField(
                  controller: notesControler,
                  decoration:
                      const InputDecoration(labelText: 'Ghi chú sự kiện'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
              ],
              Column(
                children: [
                  TaskRatingBar(
                    initialRating: _rating,
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.event.id != null)
                        FilledButton.tonalIcon(
                          onPressed: _deleteEvent,
                          label: const Text('Xoá sự kiện'),
                        ),
                      FilledButton.icon(
                        onPressed: _saveEvent,
                        label: const Text('Lưu sự kiện'),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListTile(
                    title: const Text('bật/tắt thông báo:'),
                    trailing: Switch(
                        value: widget.event.isNotification,
                        onChanged: (value) {
                          setState(() {
                            widget.event.isNotification = value;
                          });
                          _notificationEvent();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
