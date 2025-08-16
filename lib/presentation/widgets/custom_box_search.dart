import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  List<String> searchTags = [];

  final List<String> allSuggestions = [
    "burger",
    "Shawarma King",
    "KFC",
    "Pizza Hut",
    "McDonald's",
    "Subway",
    "Starbucks",
    "Taco Bell",
  ];

  List<String> filteredSuggestions = [];

  void _addTag(String text) {
    if (text.trim().isEmpty) return;
    if (!searchTags.contains(text.trim())) {
      setState(() {
        searchTags.add(text.trim());
      });
    }
    _controller.clear();
    filteredSuggestions.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      searchTags.remove(tag);
    });
  }

  void _filterSuggestions(String input) {
    if (input.isEmpty) {
      filteredSuggestions.clear();
      setState(() {});
      return;
    }
    filteredSuggestions = allSuggestions
        .where((item) =>
    item.toLowerCase().contains(input.toLowerCase()) &&
        !searchTags.contains(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              CircleSvgButton(
                svgPath: 'assets/icons/boxsearch.svg',
                size: 50.w,
                onTap: () {
                  print("تم الضغط على زر البحث");
                },
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    controller: _controller,
                    onChanged: _filterSuggestions,
                    onSubmitted: _addTag,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search food, stores, restaurants",
                      hintStyle: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              CircleSvgButton(
                svgPath: 'assets/icons/group.svg',
                size: 50.w,
                onTap: () {
                  print("تم الضغط على زر المجموعة");
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (filteredSuggestions.isNotEmpty)
            Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredSuggestions[index]),
                    onTap: () => _addTag(filteredSuggestions[index]),
                  );
                },
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: searchTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    labelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.grey[800],
                    deleteIcon: Icon(Icons.close, size: 16, color: Colors.white),
                    onDeleted: () => _removeTag(tag),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleSvgButton extends StatelessWidget {
  final String svgPath;
  final double size;
  final VoidCallback? onTap;

  const CircleSvgButton({
    super.key,
    required this.svgPath,
    this.size = 50,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size / 2),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
