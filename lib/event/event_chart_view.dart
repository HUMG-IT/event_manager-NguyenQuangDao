import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'event_detail_view.dart';
import 'event_model.dart';
import 'event_service.dart';

class EventChartView extends StatefulWidget {
  const EventChartView({super.key});

  @override
  State<EventChartView> createState() => _EventChartViewState();
}

class _EventChartViewState extends State<EventChartView> {
  final eventService = EventService();
  List<EventModel> items = [];
  int veryEasy = 0;
  int easy = 0;
  int average = 0;
  int hard = 0;
  int veryHard = 0;
  @override
  void initState() {
    super.initState();
    loadEvents();
    getRatingCounts();
  }

  Future<void> loadEvents() async {
    final events = await eventService.getAllEvents();
    setState(() {
      items = events;
    });
  }

  Future<void> getRatingCounts() async {
    final events = await eventService.getAllEvents();
    veryEasy = 0;
    easy = 0;
    average = 0;
    hard = 0;
    veryHard = 0;
    for (var event in events) {
      if (event.rating == 1) {
        veryEasy += 1;
      } else if (event.rating == 2) {
        easy += 1;
      } else if (event.rating == 3) {
        average += 1;
      } else if (event.rating == 4) {
        hard += 1;
      } else if (event.rating == 5) {
        veryHard += 1;
      }
    }
  }

  /// Hàm tính toán thời gian còn lại giữa startTime và endTime
  String calculateRemainingTime(DateTime endTime) {
    DateTime startTime = DateTime.now();
    Duration difference = endTime.difference(startTime);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    if (difference.isNegative) {
      return 'Sự kiện đã kết thúc';
    } else {
      return '$days ngày, $hours giờ, $minutes phút';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tổng hợp sự kiện'),
      ),
      body: Column(
        children: [
          const SizedBox(width: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Thống kê sự kiện',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          SizedBox(
            height: 280,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _operationIconTable(context),
            ),
          ),
          Container(child: _buildChart()),
        ],
      ),
    );
  }

  Widget _operationIconTable(BuildContext context) {
    return TDTable(
      onCellTap: (rowIndex, row, col) {
        final EventModel event = items[rowIndex];
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return EventDetailView(event: event);
          },
        )).then((value) async {
          if (value == true) {
            await getRatingCounts();
            await loadEvents();
          }
        });
      },
      columns: [
        TDTableCol(
          title: 'Tên sự kiện',
          colKey: 'title1',
          ellipsis: true,
        ),
        TDTableCol(
          title: 'Thời gian còn lại',
          colKey: 'title2',
        ),
      ],
      data: items
          .map((event) => {
                'title1': event.subject,
                'title2': calculateRemainingTime(event.endTime),
              })
          .toList(),
    );
  }

  /// Hàm xây dựng biểu đồ hình tròn
  Widget _buildChart() {
    final List<ChartData> chartData = [
      ChartData('Rất dễ', veryEasy, const Color.fromARGB(255, 7, 178, 13)),
      ChartData('Dễ', easy, const Color.fromARGB(255, 134, 187, 80)),
      ChartData('T Bình', average, Colors.amber),
      ChartData('Khó', hard, const Color.fromARGB(255, 244, 105, 105)),
      ChartData('Rất khó', veryHard, const Color.fromARGB(255, 239, 22, 6)),
    ];

    return SizedBox(
      width: 350,
      height: 350,
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: chartData,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              labelAlignment: ChartDataLabelAlignment.middle,
            ),
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.top,
          overflowMode: LegendItemOverflowMode.scroll,
          iconHeight: 10,
          iconWidth: 10,
          itemPadding: 10,
          textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}
