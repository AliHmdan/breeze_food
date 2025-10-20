import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<String> searchTags = [];

  final List<String> allSuggestions = [
    "Burger",
    "Shawarma King",
    "KFC",
    "Pizza Hut",
    "Tacos",
    "McDonald's",
    "Shish",
    "Parise"
  ];

  List<String> filteredSuggestions = [];
  bool showSuggestions = false;
  final GlobalKey _searchFieldKey = GlobalKey(); // 🔹 لتحديد موقع حقل البحث على الشاشة

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _filterSuggestions('');
        setState(() {
          showSuggestions = true;
        });
      }
    });
  }

  void _filterSuggestions(String input) {
    final query = input.trim().toLowerCase();
    setState(() {
      showSuggestions = true;
      filteredSuggestions = allSuggestions
          .where((item) =>
              item.toLowerCase().contains(query) &&
              !searchTags.contains(item))
          .toList();
    });
  }

  void _addTag(String text) {
    if (text.trim().isEmpty) return;
    if (!searchTags.contains(text)) {
      setState(() {
        searchTags.add(text);
      });
    }
    _controller.clear();
    setState(() {
      showSuggestions = false;
    });
    _focusNode.unfocus();
  }

  void _removeTag(String tag) {
    setState(() {
      searchTags.remove(tag);
    });
  }

  Widget _buildTagChip(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _removeTag(tag),
            child: Icon(
              Icons.close,
              size: 18.sp,
              color: AppColor.white,
            ),
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
          /// 🔹 المحتوى الرئيسي
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                showSuggestions = false;
              });
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ✅ شريط البحث
                    Row(
                      children: [
                        CustomArrow(
                          onTap: () {},
                          color: AppColor.black,
                          background: AppColor.white,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            key: _searchFieldKey, // 📍 حفظ موقعه
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: TextField(
                              focusNode: _focusNode,
                              controller: _controller,
                              onTap: () => _filterSuggestions(_controller.text),
                              onChanged: (val) => _filterSuggestions(val),
                              onSubmitted: (val) => _addTag(val),
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

                    /// ✅ التاغات
                    if (searchTags.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Wrap(
                          children:
                              searchTags.map((t) => _buildTagChip(t)).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 القائمة المنسدلة فوق المحتوى
          if (showSuggestions)
            Builder(
              builder: (context) {
                // الحصول على موقع مربع البحث
                final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
                final offset = renderBox?.localToGlobal(Offset.zero);
                final topPosition = offset?.dy ?? 110.0; // fallback في حال null

                return Positioned(
                  top: topPosition + 45.h, // مباشرة تحت مربع البحث
                  left: 24.w,
                  right: 24.w,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            (filteredSuggestions.length * 500.0).h.clamp(0, 500.h),
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
                      child: filteredSuggestions.isEmpty
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
                                final suggestion =
                                    filteredSuggestions[index];
                                return InkWell(
                                  onTap: () => _addTag(suggestion),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 14.h),
                                    child: Expanded(
                                      child: Text(
                                        suggestion,
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: 15.sp,
                                          fontFamily: "Manrope",
                                        ),
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
