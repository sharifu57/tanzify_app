import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tanzify_app/components/containers/searchBarApp.dart';
import 'package:tanzify_app/components/spinners/spinkit.dart';
import 'package:tanzify_app/pages/constants.dart';
import 'dart:async';

class SeeAllProjects extends StatefulWidget {
  const SeeAllProjects({super.key});

  @override
  State<SeeAllProjects> createState() => _SeeAllProjectsState();
}

class _SeeAllProjectsState extends State<SeeAllProjects> {
  bool _isLoading = true;
  bool _isLoadingMore = false;
  final int _pageSize = 10;
  int _currentPage = 1;
  final List<int> _items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startLoadingTimer();
    _loadMoreItems();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _startLoadingTimer() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _loadMoreItems() {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _items.addAll(List.generate(_pageSize,
            (index) => index + 1 + (_pageSize * (_currentPage - 1))));
        _currentPage++;
        _isLoadingMore = false;
      });
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !_isLoadingMore) {
      _loadMoreItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_sharp,
            size: 24,
            color: Constants.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Projects',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const SearchBarApp(),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                sliver: Skeletonizer.sliver(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Card(
                          child: ListTile(
                            title: Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.grey[300],
                            ),
                            subtitle: Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.grey[300],
                            ),
                            trailing: const Icon(Icons.ac_unit),
                          ),
                        );
                      },
                      childCount: _pageSize,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == _items.length) {
                        return const Center(child: WaveSpinKit());
                      }
                      return Card(
                        child: ListTile(
                          title: Text('Item number ${_items[index]} as title'),
                          subtitle: const Text('Subtitle here'),
                          trailing: const Icon(Icons.ac_unit),
                        ),
                      );
                    },
                    childCount: _items.length + 1,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
