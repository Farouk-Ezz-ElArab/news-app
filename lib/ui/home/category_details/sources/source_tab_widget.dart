import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/di/di.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/ui/home/category_details/cubit/source_view_model.dart';
import 'package:news_app/ui/home/category_details/news/news_widget.dart';
import 'package:news_app/ui/home/category_details/sources/source_name.dart';
import 'package:news_app/utils/app_colors.dart';

import '../cubit/sources_states.dart';

class SourceTabWidget extends StatefulWidget {
  List<Source> sourcesList;

  SourceTabWidget({super.key, required this.sourcesList});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  SourceViewModel viewModel = SourceViewModel(
    sourceRepository: injectSourceRepository(),
  );

  @override
  void initState() {
    viewModel.changeSelectedIndex(0, widget.sourcesList[0].id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: Theme.of(context).indicatorColor,
            dividerColor: AppColors.transparentColor,
            onTap: (index) {
              viewModel.changeSelectedIndex(
                index,
                widget.sourcesList[index].id ?? '',
              );
            },
            tabs: widget.sourcesList.map((source) {
              final index = widget.sourcesList.indexOf(source);
              return SourceName(
                source: source,
                isSelected: viewModel.index == index,
              );
            }).toList(),
          ),
          Expanded(
            child: BlocBuilder<SourceViewModel, SourcesStates>(
              bloc: viewModel,
              builder: (context, state) {
                if (state is SourceLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SourceErrorState) {
                  return Center(child: Text(state.errorMessage));
                }
                return NewsWidget(
                  source: widget.sourcesList[viewModel.index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
