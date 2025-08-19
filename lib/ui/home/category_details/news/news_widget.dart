import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/ui/home/category_details/news/cubit/news_view_model.dart';

import '../../../../model/NewsResponse.dart';
import '../../../../model/SourceResponse.dart';
import 'news_bottom_sheet.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;

  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  late NewsViewModel viewModel;
  late final PagingController<int, News> pagingController;

  // = PagingController<int, News>(
  //   getNextPageKey: (state) =>
  //   state.lastPageIsEmpty ? null : state.nextIntPageKey,
  //   fetchPage: (pageKey) =>
  //       ApiManager.getPagedNews(
  //         page: pageKey,
  //         sourceId: widget.source.id ?? '',
  //       ),
  // );
  @override
  void initState() {
    super.initState();
    viewModel = NewsViewModel();
    pagingController = PagingController(
      getNextPageKey: (state) {
        if (state.lastPageIsEmpty) {
          return null;
        }
        return state.nextIntPageKey;
      },
      fetchPage: (pageKey) async {
        return await viewModel.getPagedNews(
          sourceId: widget.source.id ?? '',
          page: pageKey,
        );
      },
    );
  }
  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  // @override
  // void didUpdateWidget(covariant NewsWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.source.id != widget.source.id) {
  //     pagingController.refresh();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PagingListener(
      controller: pagingController,
      builder: (context, state, fetchNextPage) =>
          PagedListView<int, News>(
            state: state,
            fetchNextPage: fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate<News>(
              firstPageProgressIndicatorBuilder: (context) =>
                  Center(
                    child: CircularProgressIndicator(color: Colors.grey),
                  ),
              firstPageErrorIndicatorBuilder: (context) =>
                  errorWidget(
                    context,
                    message: 'Something went wrong. Please check your connection.',
                  ),

              itemBuilder: (context, newsItem, index) =>
                  InkWell(
                    onTap: () => showCustomBottomSheet(newsItem),
                    child: NewsItem(news: newsItem),
                  ),
            ),
          ),
    );
  }

  void showCustomBottomSheet(News selectedNews) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return NewsBottomSheet(
          selectedNews: selectedNews,
          url: Uri.parse(selectedNews.url!),
        );
      },
      backgroundColor: Theme.of(context).indicatorColor,
    );
  }

  Widget errorWidget(BuildContext context, {String? message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(message ?? 'Error loading data', style: Theme
              .of(context)
              .textTheme
              .headlineMedium, textAlign: TextAlign
              .center,),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => pagingController.refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

