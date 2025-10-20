import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/blocs/search/search_cubit.dart';
import 'package:freeza_food/blocs/search/search_state.dart';
import 'package:freeza_food/data/repositories/search_repository.dart';
import 'package:freeza_food/models/search_history_model.dart';
import 'package:freeza_food/models/search_result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final GlobalKey _searchFieldKey = GlobalKey(); // لتحديد موضع الحقل

  List<String> searchTags = [];
  List<SearchHistoryModel> searchHistory = [];
  List<dynamic> searchResults = [];

  final List<String> allSuggestions = const [
  ];

  List<String> filteredSuggestions = [];
  bool showSuggestions = false;
  bool showHistory = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() => showSuggestions = true);
        if (_controller.text.isEmpty) {
          setState(() => showHistory = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterSuggestions(String input) {
    final query = input.trim().toLowerCase();
    setState(() {
      showSuggestions = true;
      showHistory = false;
      filteredSuggestions = allSuggestions
          .where((item) =>
              item.toLowerCase().contains(query) && !searchTags.contains(item))
          .toList();
    });
  }

  void _addTag(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    if (!searchTags.contains(t)) {
      setState(() => searchTags.add(t));
    }
    _controller.clear();
    setState(() => showSuggestions = false);
    _focusNode.unfocus();
  }

  void _removeTag(String tag) {
    setState(() => searchTags.remove(tag));
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<SearchCubit>().performSearch(query.trim());
      _addTag(query.trim());
    }
  }

  void _onHistoryItemTap(String query) {
    _controller.text = query;
    _performSearch(query);
  }

  Widget _buildTagChip(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Icon(Icons.close, size: 18.sp, color: AppColor.white),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: "Manrope",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() => showSuggestions = false);
              setState(() => showHistory = false);
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شريط البحث
                    Row(
                      children: [
                        CustomArrow(
                          onTap: () => Navigator.pop(context),
                          color: AppColor.black,
                          background: AppColor.white,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            key: _searchFieldKey,
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              onTap: () {
                                if (_controller.text.isEmpty) {
                                  setState(() => showHistory = true);
                                }
                                _filterSuggestions(_controller.text);
                              },
                              onChanged: _filterSuggestions,
                              onSubmitted: _performSearch,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.w),
                                filled: true,
                                fillColor: AppColor.white,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    color: AppColor.gry,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                ),
                                hintText: "Search food, stores, restaurants",
                                hintStyle: TextStyle(
                                  color: AppColor.gry,
                                  fontSize: 14.sp,
                                  fontFamily: "Manrope",
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(50.0.r),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/boxsearch.svg',
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                      ],
                    ),

                    // التاغات
                    if (searchTags.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 100.h),
                        child: Wrap(
                          children:
                              searchTags.map((t) => _buildTagChip(t)).toList(),
                        ),
                      ),

                    // نتائج البحث
                    BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchResultLoaded) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: state.result.data.length,
                              itemBuilder: (context, index) {
                                final item = state.result.data[index];
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    item.toString(),
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 14.sp,
                                      fontFamily: "Manrope",
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is SearchFailure) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                state.error,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

        if (showSuggestions || showHistory)
          Builder(
            builder: (context) {
              final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
              final offset = renderBox?.localToGlobal(Offset.zero);
              final topPosition = offset?.dy ?? 110.0; // Fallback

              return Positioned(
                top: topPosition + 45.h, // تحت مربع البحث مباشرة
                left: 24.w,
                right: 24.w,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 300.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: showHistory
                        ? BlocBuilder<SearchCubit, SearchState>(
                            builder: (context, state) {
                              if (state is SearchHistoryLoaded) {
                                if (state.history.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Text(
                                        'No search history',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.all(10.w),
                                  itemCount: state.history.length,
                                  separatorBuilder: (_, __) => Divider(
                                    color: AppColor.black,
                                    height: 1.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final historyItem = state.history[index];
                                    return InkWell(
                                      onTap: () => _onHistoryItemTap(historyItem.query),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/time.svg',
                                              width: 16.w,
                                              height: 16.h,
                                              color: AppColor.gry,
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Text(
                                                historyItem.query,
                                                style: TextStyle(
                                                  color: AppColor.black,
                                                  fontSize: 15.sp,
                                                  fontFamily: "Manrope",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (state is SearchLoading) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.w),
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        : filteredSuggestions.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: Text(
                                    'No suggestions found',
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.all(10.w),
                                itemCount: filteredSuggestions.length,
                                separatorBuilder: (_, __) => Divider(
                                  color: AppColor.black,
                                  height: 1.h,
                                ),
                                itemBuilder: (context, index) {
                                  final suggestion = filteredSuggestions[index];
                                  return InkWell(
                                    onTap: () => _addTag(suggestion),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 14.h),
                                      child: Text(
                                        suggestion,
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15.sp,
                                          fontFamily: "Manrope",
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              );
            },
          ),
      ],
    ),
    );
  }
}
