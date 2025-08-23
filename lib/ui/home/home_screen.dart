import 'package:flutter/material.dart';
import 'package:news_app/ui/home/category_details/category_details.dart';
import 'package:news_app/ui/home/widgets/drawer_widget.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../api/api_manager.dart';
import '../../l10n/app_localizations.dart';
import '../../model/NewsResponse.dart';
import '../../model/category.dart';
import '../../providers/app_language_provider.dart';
import '../../providers/app_theme_provider.dart';
import 'category_details/news/news_bottom_sheet.dart';
import 'category_details/news/news_item.dart';
import 'category_fragment/category_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: _isSearching
            ? TextField(
                enabled: true,
                cursorColor: Theme.of(context).indicatorColor,
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  focusColor: AppColors.whiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.whiteColor),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).indicatorColor,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.whiteColor),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _isSearching = false;
                      });
                    },
                  ),
                  hintStyle: Theme.of(context).textTheme.headlineLarge,
                  hintText: AppLocalizations.of(context)!.search,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (text) {
                  _searchQuery = text;
                  setState(() {});
                },
              )
            : Text(
                selectedCategory == null
                    ? AppLocalizations.of(context)!.general
                    : selectedCategory!.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
        actions: _isSearching
            ? []
            : [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
                SizedBox(width: width * 0.02),
              ],
      ),
      drawer: DrawerWidget(onBackHomeClick: onBackHomeClick),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_searchQuery.isNotEmpty) {
      return _buildSearchResults();
    } else if (selectedCategory == null) {
      return CategoryFragment(onViewAllClick: onViewAllClick);
    } else {
      return CategoryDetails(category: selectedCategory!);
    }
  }

  Widget _buildSearchResults() {
    if (_searchQuery.isEmpty) {
      return Center(child: Text("Start typing to search..."));
    }
    final apiManager = ApiManager();

    return FutureBuilder<NewsResponse?>(
      future: apiManager.getNewsBySourceId(
        '',
        searchQuery: _searchQuery,
        searchIn: "title,description",
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData ||
            snapshot.data!.articles == null ||
            snapshot.data!.articles!.isEmpty) {
          return Center(child: Text("No results found for \"$_searchQuery\""));
        }

        var articles = snapshot.data!.articles!;
        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Theme.of(context).indicatorColor,
                  context: context,
                  builder: (context) => NewsBottomSheet(
                    selectedNews: articles[index],
                    url: Uri.parse(articles[index].url!),
                  ),
                );
              },
              child: NewsItem(news: articles[index]),
            );
          },
        );
      },
    );
  }

  Category? selectedCategory;

  void onViewAllClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    _searchQuery = '';
    _isSearching = false;
    _searchController.clear();
    setState(() {});
  }

  void onBackHomeClick() {
    selectedCategory = null;
    _searchQuery = '';
    _isSearching = false;
    _searchController.clear();
    setState(() {});
  }
}