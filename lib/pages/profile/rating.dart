import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:tanzify_app/pages/constants.dart';

class Rating extends StatefulWidget {
  final double initialRating;
  const Rating({super.key, required this.initialRating});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  late double rating;
  @override
  void initState() {
    // TODO: implement initState
    rating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PannableRatingBar(
      gestureType: GestureType.tapOnly,
      rate: rating,
      items: List.generate(
          5,
          (index) => const RatingWidget(
                selectedColor: Constants.secondaryColor,
                unSelectedColor: Colors.grey,
                child: Icon(
                  Icons.star,
                  size: 20,
                ),
              )),
      onHover: (value) {
        // the rating value is updated every time the cursor moves over a new item.
        setState(() {
          rating = value;
        });
      },
    );
  }
}
