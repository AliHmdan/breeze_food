import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/data/model/search/menu_item_lite.dart';
import 'package:breezefood/presentation/widgets/custom_arrow.dart';
import 'package:breezefood/presentation/widgets/home/most_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ✅ تعريف مبسط لموديل المطعم المستخدم في نتائج البحث فقط
class Restaurant {
  final String name;
  final List<MenuItemLite> items;

  Restaurant({required this.name, required this.items});
}

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

  bool _loading = false;
  String? _error;
  List<Restaurant> _restaurants = [];

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

  void _addTagLocally(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    if (!searchTags.contains(t)) {
      setState(() => searchTags.add(t));
    }
  }

  // ✅ تحويل استجابة الـ API إلى List<Restaurant>
  List<Restaurant> _mapApiToRestaurants(dynamic json) {
    final List data = (json as List?) ?? [];
    return data.map<Restaurant>((r) {
      final name = (r['name'] ?? 'Restaurant').toString();
      final itemsJson = (r['items'] as List? ?? []);

      final items = itemsJson.map<MenuItemLite>((m) {
        return MenuItemLite(
          name: (m['name'] ?? '').toString(),
          subtitle: (m['subtitle'] ?? '').toString(),
          image: (m['image'] ?? '').toString(),
          price: (m['price'] ?? '').toString(),
        );
      }).toList();

      return Restaurant(name: name, items: items);
    }).toList();
  }

  // ✅ محاكاة لجلب نتائج البحث
  Future<List<Restaurant>> _fetchResults(String q) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final fakeJson = [
      {
        "name": "Chicken House",
        "items": [
          {
            "name": "Chicken shish",
            "subtitle": "burger king",
            "image": "assets/images/shesh.jpg",
            "price": "2.00\$"
          },
          {
            "name": "Grilled Chicken",
            "subtitle": "burger king",
            "image": "assets/images/shawarma_box.png",
            "price": "3.50\$"
          },
          {
            "name": "Chicken Wrap",
            "subtitle": "burger king",
            "image": "assets/images/shesh.jpg",
            "price": "2.75\$"
          },
        ]
      },
      {
        "name": "Pizza Hut",
        "items": [
          {
            "name": "Pepperoni Pizza",
            "subtitle": "Cheesy crust",
            "image": "assets/images/shawarma_box.png",
            "price": "5.00\$"
          },
           {
            "name": "Pepperoni Pizza",
            "subtitle": "Cheesy crust",
            "image": "assets/images/shawarma_box.png",
            "price": "5.00\$"
          },
           {
            "name": "Pepperoni Pizza",
            "subtitle": "Cheesy crust",
            "image": "assets/images/shawarma_box.png",
            "price": "5.00\$"
          },
        ]
      },
    ];

    return _mapApiToRestaurants(fakeJson);
  }

  void _applySuggestionToField(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    setState(() => showSuggestions = false);
  }

  Future<void> _performSearch() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;

    _addTagLocally(q);

    setState(() {
      showSuggestions = false;
      _error = null;
      _loading = true;
      _restaurants = [];
    });
    _focusNode.unfocus();

    try {
      final data = await _fetchResults(q);
      setState(() {
        _restaurants = data;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ أثناء جلب النتائج';
        _loading = false;
      });
    }
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

  Widget _buildResultsArea() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Text(_error!, style: const TextStyle(color: Colors.white70)),
      );
    }
    if (_restaurants.isEmpty) {
      return Center(
        child: Text(
          'ابدأ بالبحث عن وجبة لعرض المطاعم',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      );
    }

    return ListView.builder(
      itemCount: _restaurants.length,
      itemBuilder: (context, i) {
        final restaurant = _restaurants[i];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
  padding: const EdgeInsets.only(bottom: 8, top: 10),
  child: Row(
    children: [
      // صورة شعار المطعم
      ClipOval(
        child: Image.asset(
          'assets/images/shawarma_box.png', // ← استبدل بمسار شعار المطعم
          width: 35.w,
          height: 35.w,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(width: 8.w),

      // اسم المطعم + مدة التوصيل
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.white70, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  "15-40 min",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
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

      // تقييم وعدد الطلبات
      Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            "4.9",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            "500+ Order",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    ],
  ),
),

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
                      itemCount: restaurant.items.length,
                      itemBuilder: (context, index) {
                        final item = restaurant.items[index];
                        return Container(
                          width: itemWidth,
                          margin: EdgeInsets.only(right: 10.w),
                          child: PopularItemCard(
                            imagePath: item.image,
                            title: item.name,
                            subtitle: item.subtitle,
                            price: item.price,
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
      },
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
                              onTap: () => _filterSuggestions(_controller.text),
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
                    if (searchTags.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Wrap(
                          children:
                              searchTags.map((t) => _buildTagChip(t)).toList(),
                        ),
                      ),
                    SizedBox(height: 12.h),
                    Expanded(child: _buildResultsArea()),
                  ],
                ),
              ),
            ),
          ),
          if (showSuggestions)
            Builder(
              builder: (context) {
                final renderBox = _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
                final offset = renderBox?.localToGlobal(Offset.zero);
                final topPosition = offset?.dy ?? 110.0;
                final double computed = (filteredSuggestions.length * 48.0.h);
                final double maxHeight = computed > 300.0.h ? 300.0.h : computed;

                return Positioned(
                  top: topPosition + 45.h,
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
                                  onTap: () => _applySuggestionToField(suggestion),
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
    );
  }
}
