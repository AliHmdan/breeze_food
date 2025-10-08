import 'package:breezefood/core/constans/color.dart';
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
  List<String> searchTags = [];

  final List<String> allSuggestions = [
    "Burger",
    "India foods",
    "Chrispy",
    "Japanese Foods",
    "Noodles",
    "Drinks",
    "Hots foods",
    "Sea foods",
  ];

  List<String> filteredSuggestions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    filteredSuggestions = [];
  }

  void _addTag(String text) {
    if (text.trim().isEmpty) return;
    if (!searchTags.contains(text.trim())) {
      setState(() {
        searchTags.add(text.trim());
      });
    }
    _controller.clear();
    setState(() {
      filteredSuggestions.clear();
      showSuggestions = false;
    });
  }

  void _removeTag(String tag) {
    setState(() {
      searchTags.remove(tag);
    });
  }

  void _filterSuggestions(String input) {
    if (input.isEmpty) {
      setState(() {
        filteredSuggestions = List.from(allSuggestions);
      });
      return;
    }
    setState(() {
      filteredSuggestions = allSuggestions
          .where(
            (item) =>
                item.toLowerCase().contains(input.toLowerCase()) &&
                !searchTags.contains(item),
          )
          .toList();
    });
  }

  final Color suggestionTextColor = AppColor.gry;
  final Color dividerColor = AppColor.gry;
  final double dividerThickness = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.black,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _controller,
                    onTap: () {
                      setState(() {
                        filteredSuggestions = List.from(allSuggestions);
                        showSuggestions = true;
                      });
                    },
                    onChanged: _filterSuggestions,
                    onSubmitted: _addTag,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
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
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: SvgPicture.asset(
                  'assets/icons/boxsearch.svg',
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // suggestions (fixed height content, ListView shrinkWrapped)
            if (showSuggestions && filteredSuggestions.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredSuggestions.length,
                    separatorBuilder: (context, index) => Divider(
                      color: dividerColor,
                      thickness: dividerThickness,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          filteredSuggestions[index],
                          style: TextStyle(
                            color: suggestionTextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        onTap: () => _addTag(filteredSuggestions[index]),
                      );
                    },
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // area with chips — allow it to fill remaining space and scroll if necessary
            Expanded(
              child: SingleChildScrollView(
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
                        deleteIcon: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
