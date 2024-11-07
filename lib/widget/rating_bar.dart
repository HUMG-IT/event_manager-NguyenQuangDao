import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TaskRatingBar extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingUpdate;

  const TaskRatingBar({
    super.key,
    required this.initialRating,
    required this.onRatingUpdate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TaskRatingBarState createState() => _TaskRatingBarState();
}

class _TaskRatingBarState extends State<TaskRatingBar> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  String ratingToText(double rating) {
    switch (rating.toInt()) {
      case 1:
        return 'Rất dễ';
      case 2:
        return 'Dễ';
      case 3:
        return 'Trung bình';
      case 4:
        return 'Khó';
      case 5:
        return 'Rất khó';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Đánh giá công việc: ${ratingToText(_rating)}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 40.0,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              default:
                return const Icon(
                  Icons.star,
                  color: Colors.grey,
                );
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
            widget.onRatingUpdate(rating); // Truyền giá trị rating ra ngoài
          },
        ),
      ],
    );
  }
}
