import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:freeza_food/blocs/search/search_cubit.dart';
import 'package:freeza_food/blocs/search/search_state.dart';
import 'package:freeza_food/data/repositories/search_repository.dart';
import 'package:freeza_food/models/search_history_model.dart';
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

  final GlobalKey _searchFieldKey = GlobalKey();

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
    // Only clear controller and unfocus if this is from suggestion tap
    // Not from search submission
    if (!_controller.text.contains(t)) {
      _controller.clear();
      setState(() => showSuggestions = false);
      _focusNode.unfocus();
    }
  }

  void _removeTag(String tag) {
    setState(() => searchTags.remove(tag));
    if (searchTags.isEmpty) {
      context.read<SearchCubit>().clearState();
      setState(() => showHistory = true);
    }
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      context.read<SearchCubit>().performSearch(query.trim());

      setState(() => showHistory = false);
      setState(() => showSuggestions = false);
      _addTag(query.trim());
    }
  }

  void _onHistoryItemTap(String query) {
    _controller.text = query;
    _performSearch(query);
  }

  void _clearSearch() {
    _controller.clear();
    setState(() => showHistory = true);
    setState(() => showSuggestions = false);
    context.read<SearchCubit>().clearState();
    context.read<SearchCubit>().loadSearchHistory();
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
                       GestureDetector(
                         onTap: _clearSearch,
                         child: Container(
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
                       ),
                    ],
                  ),

                   // التاغات
                   if (searchTags.isNotEmpty)
                     Padding(
                       padding: EdgeInsets.only(top: 20.h),
                       child: Wrap(
                         children:
                             searchTags.map((t) => _buildTagChip(t)).toList(),
                       ),
                     ),

                   // نتائج البحث
                   BlocBuilder<SearchCubit, SearchState>(
                     builder: (context, state) {
                       if (state is SearchResultLoaded) {
                         if (state.result.data.isEmpty) {
                           return Expanded(
                             child: Center(
                               child: Text(
                                 'No results found',
                                 style: TextStyle(
                                   color: AppColor.white,
                                   fontSize: 14.sp,
                                 ),
                               ),
                             ),
                           );
                         }

                         return Expanded(
                           child: ListView.builder(
                             itemCount: state.result.data.length,
                             itemBuilder: (context, index) {
                               final resultItem = state.result.data[index];
                               return Container(
                                 margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                                 padding: EdgeInsets.all(16.w),
                                 decoration: BoxDecoration(
                                   color: AppColor.white,
                                   borderRadius: BorderRadius.circular(12.r),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.black.withOpacity(0.1),
                                       blurRadius: 4,
                                       offset: const Offset(0, 2),
                                     ),
                                   ],
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     // Restaurant name
                                     Text(
                                       resultItem.restaurant.name,
                                       style: TextStyle(
                                         color: AppColor.black,
                                         fontSize: 16.sp,
                                         fontFamily: "Manrope",
                                         fontWeight: FontWeight.bold,
                                       ),
                                     ),
                                     SizedBox(height: 8.h),
                                     // Items
                                     if (resultItem.items.isNotEmpty) ...[
                                       Text(
                                         'Items:',
                                         style: TextStyle(
                                           color: AppColor.gry,
                                           fontSize: 14.sp,
                                           fontFamily: "Manrope",
                                           fontWeight: FontWeight.w600,
                                         ),
                                       ),
                                       SizedBox(height: 4.h),
                                       ...resultItem.items.map((item) => Padding(
                                         padding: EdgeInsets.only(left: 8.w, bottom: 2.h),
                                         child: Text(
                                           '• ${item.names.en} (${item.names.ar})',
                                           style: TextStyle(
                                             color: AppColor.black,
                                             fontSize: 14.sp,
                                             fontFamily: "Manrope",
                                           ),
                                         ),
                                       )),
                                     ],
                                   ],
                                 ),
                               );
                             },
                           ),
                         );
                       } else if (state is SearchFailure) {
                         return Expanded(
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(
                                   Icons.error_outline,
                                   color: AppColor.white,
                                   size: 48.sp,
                                 ),
                                 SizedBox(height: 16.h),
                                 Text(
                                   state.error,
                                   style: TextStyle(
                                     color: AppColor.white,
                                     fontSize: 14.sp,
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                               ],
                             ),
                           ),
                         );
                       } else if (state is SearchLoading) {
                         return Expanded(
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 CircularProgressIndicator(
                                   color: AppColor.primaryColor,
                                 ),
                                 SizedBox(height: 16.h),
                                 Text(
                                   'Searching...',
                                   style: TextStyle(
                                     color: AppColor.white,
                                     fontSize: 14.sp,
                                   ),
                                 ),
                               ],
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
          builder: (context) {// Fallback
            final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
            final offset = renderBox?.localToGlobal(Offset.zero);

            return Positioned(
              top: 110.0,
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
