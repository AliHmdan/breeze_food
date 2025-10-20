import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/custom_arrow.dart';
import 'package:flutter/material.dart';
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

  final List<String> allSuggestions = const [
    "Burger",
    "Shawarma King",
    "KFC",
    "Pizza Hut",
    "Tacos",
    "McDonald's",
    "Shish",
    "Parise",
  ];

  List<String> filteredSuggestions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _filterSuggestions(_controller.text);
        setState(() => showSuggestions = true);
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
          // المحتوى الرئيسي
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() => showSuggestions = false);
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
                              onTap: () => _filterSuggestions(_controller.text),
                              onChanged: _filterSuggestions,
                              onSubmitted: _addTag,
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

          // القائمة المنسدلة فوق المحتوى
          if (showSuggestions)
            Builder(
              builder: (context) {
                // تحديد موقع حقل البحث على الشاشة
                final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
                final offset = renderBox?.localToGlobal(Offset.zero);
                final topPosition = offset?.dy ?? 110.0; // Fallback

                // احسب أقصى ارتفاع منطقي للقائمة
                final double computed = (filteredSuggestions.length * 48.0.h);
                final double maxHeight =
                    computed > 300.0.h ? 300.0.h : computed; // cap عند 300.h

                return Positioned(
                  top: topPosition + 45.h, // تحت مربع البحث مباشرة
                  left: 24.w,
                  right: 24.w,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: maxHeight, // double صحيح
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
                                final suggestion = filteredSuggestions[index];
                                return InkWell(
                                  onTap: () => _addTag(suggestion),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 14.h),
                                    // ❗ أزلنا Expanded الذي كان يسبب الخطأ
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
