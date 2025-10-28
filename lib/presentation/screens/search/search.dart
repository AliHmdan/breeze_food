import 'package:breezefood/blocs/search/search_cubit.dart';
import 'package:breezefood/blocs/search/search_state.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/custom_arrow.dart';
import 'package:breezefood/presentation/widgets/home/most_popular.dart';
import 'package:breezefood/data/model/search/search_result_model.dart'; // موديلات ال API
import 'package:breezefood/data/model/search/search_history_model.dart'; // موديل التاريخ
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _stackKey = GlobalKey(); 
  final GlobalKey _searchFieldKey = GlobalKey();

  // وسوم المستخدم المحلية
  List<String> searchTags = [];

  // تاريخ البحث القادم من API
  List<SearchHistoryModel> _history = [];

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

    // تحميل التاريخ من السيرفر عند فتح الصفحة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().loadSearchHistory();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterSuggestions(String input) {
    final q = input.trim().toLowerCase();

    // دمج اقتراحات ثابتة + تاريخ البحث (بدون تكرار) — اختياري
    final historyQueries = _history.map((h) => h.query).toSet().toList();
    final base = [...historyQueries, ...allSuggestions];

    setState(() {
      showSuggestions = true;
      filteredSuggestions = base
          .where(
            (item) =>
                item.toLowerCase().contains(q) && !searchTags.contains(item),
          )
          .toList();
    });
  }

  void _addTagLocally(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    if (!searchTags.contains(t)) {
      setState(() => searchTags.add(t));
    }
  }

  void _applySuggestionToField(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    setState(() => showSuggestions = false);
  }

  // البحث عبر الكيوبت (لا state محلي)
  Future<void> _performSearch() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;

    _addTagLocally(q);
    setState(() => showSuggestions = false);
    _focusNode.unfocus();

    context.read<SearchCubit>().performSearch(q);
  }

  void _removeTag(String tag) {
    setState(() => searchTags.remove(tag));
  }

  /// Chip للوسوم (بدون تاريخ) بنفس روح التصميم
  Widget _buildTagChipFromString(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () => _removeTag(tag),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(Icons.close, size: 18.sp, color: Colors.white),
            ),
          ),
          SizedBox(width: 4.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
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

  /// Chip لعناصر التاريخ (بدون إظهار التاريخ، ضغط = بحث، X = حذف محلي)
  Widget _buildHistoryChip(SearchHistoryModel h) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              setState(() {
                _history.removeWhere((x) => x.id == h.id);
              });
            },
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(Icons.close, size: 18.sp, color: Colors.white),
            ),
          ),
          SizedBox(width: 4.w),
          InkWell(
            onTap: () {
              _applySuggestionToField(h.query);
              _performSearch();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                h.query,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: "Manrope",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// بلوك عنصر مطعم (يعتمد على SearchResultItem من API)
  Widget _restaurantBlock(SearchResultItem block) {
    final r = block.restaurant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // رأس المطعم
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/shawarma_box.png', // شعار افتراضي
                  width: 35.w,
                  height: 35.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8.w),

              // اسم المطعم + مدة التوصيل + التقييم من API
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSubTitle(
                      subtitle: r.name,
                      color: AppColor.white,
                      fontsize: 14.sp,
                    ),
                   
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white70,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        CustomSubTitle(
                          subtitle: "15-40 min",
                          color: AppColor.white,
                          fontsize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // فاصل عمودي
              Container(
                height: 25.h,
                width: 1,
                color: Colors.white24,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
              ),

              // التقييم وعدد الطلبات
              Row(
                children: [
                  Icon(Icons.star, color: AppColor.yellow, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    (r.rating.avg?.toStringAsFixed(1) ?? "—"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${r.rating.count}+ Order",
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ],
              ),
            ],
          ),
        ),

        // قائمة العناصر الأفقية
        RepaintBoundary(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 8,
              right: 0.2,
            ),
            decoration: BoxDecoration(
              color: AppColor.LightActive,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 178,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / 2.3;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: block.items.length,
                  itemBuilder: (context, index) {
                    final item = block.items[index];
                    final title = item.names.en; // عنوان
                    final subtitle = item.names.en; // سطر ثانٍ

                    return Container(
                      width: itemWidth,
                      margin: EdgeInsets.only(right: 10.w),
                      child: PopularItemCard(
                        imagePath:
                            'assets/images/shawarma_box.png', // لا يوجد image في الموديل
                        title: title,
                        subtitle: subtitle,
                        price: "—", // لا يوجد price في الموديل
                        onFavoriteToggle: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // نلف الـ Scaffold بمستمع يلتقط تاريخ البحث ويحدّث _history
    return BlocListener<SearchCubit, SearchState>(
      listenWhen: (prev, curr) => curr is SearchHistoryLoaded,
      listener: (context, state) {
        if (state is SearchHistoryLoaded) {
          setState(() {
            _history = state.history;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.Dark,
        body: Stack(
           key: _stackKey,
  clipBehavior: Clip.none,
          children: [
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
                                onTap: () =>
                                    _filterSuggestions(_controller.text),
                                onChanged: _filterSuggestions,
                                onSubmitted: (_) => _performSearch(),
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
                          InkWell(
                            onTap: _performSearch,
                            borderRadius: BorderRadius.circular(50.0.r),
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

                      // وسوم المستخدم إن وُجدت وإلا نعرض التاريخ
                      if (searchTags.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: searchTags
                                .map((t) => _buildTagChipFromString(t))
                                .toList(),
                          ),
                        )
                      else if (_history.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: _history
                                .map((h) => _buildHistoryChip(h))
                                .toList(),
                          ),
                        ),

                      SizedBox(height: 12.h),

                      // النتائج من State (نتائج البحث + لودينغ + أخطاء)
                      Expanded(
                        child: BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, state) {
                            if (state is SearchLoading) {
                              return Center(
                                child: Lottie.asset(
                                  'assets/lottie/loading.json',
                                  width: 120.w,
                                  height: 120.h,
                                ),
                              );
                            }

                            if (state is SearchFailure) {
                              return Center(
                                child: Text(
                                  state.error,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              );
                            }

                            if (state is SearchResultLoaded) {
                              final results = state.result.data;
                              if (results.isEmpty) {
                                return Center(
                                  child: Text(
                                    'لا توجد نتائج للعرض',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: results.length,
                                itemBuilder: (context, i) =>
                                    _restaurantBlock(results[i]),
                              );
                            }

                            // الحالة الابتدائية (قبل أي بحث)
                            return Center(
                              child: Text(
                                'ابدأ بالبحث عن وجبة لعرض المطاعم',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // قائمة الاقتراحات المنسدلة
            if (showSuggestions)
  Builder(
    builder: (context) {
      final fieldBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
      final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;

      if (fieldBox == null || stackBox == null) {
        return const SizedBox.shrink();
      }

      // موضع الحقل عالمياً
      final fieldGlobal = fieldBox.localToGlobal(Offset.zero);
      // موضع الـ Stack عالمياً
      final stackGlobal = stackBox.localToGlobal(Offset.zero);
      // نحول إلى إحداثيات محلية بالنسبة للـ Stack
      final localTopLeft = fieldGlobal - stackGlobal;

      // ارتفاع الحقل الحقيقي (بدل 45.h)
      final fieldHeight = fieldBox.size.height;

      final double computed = (filteredSuggestions.length * 48.0.h);
      final double maxHeight = computed > 300.0.h ? 300.0.h : computed;

      return Positioned(
        top: localTopLeft.dy + fieldHeight, // أسفل الحقل مباشرة
        left: 24.w,
        right: 24.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(maxHeight: maxHeight),
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
                    separatorBuilder: (_, __) =>
                        Divider(color: AppColor.black, height: 1.h),
                    itemBuilder: (context, index) {
                      final suggestion = filteredSuggestions[index];
                      return InkWell(
                        onTap: () {
                          _applySuggestionToField(suggestion);
                          _performSearch();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 14.h,
                          ),
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
      ),
    );
  }
}
