import 'package:flutter/material.dart';
import 'package:tanzify_app/pages/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        hintMaxLines: 3,
        labelText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            color: Constants.borderColor,
          ),
        ),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
