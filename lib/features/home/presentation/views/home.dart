import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_cubit.dart';
import 'package:flutter_task/features/home/presentation/widgets/appbar.dart';

import '../../../../core/common/colors.dart';
import '../controller/cubit/repository_state.dart';
import '../widgets/list_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
 final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<RepositoryCubit>().loadRepositories();
    _searchController.addListener(_onSearchChanged);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<RepositoryCubit>().loadRepositories();
    }
  }

  void _onSearchChanged() {
    context.read<RepositoryCubit>().filterRepositories(_searchController.text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.deepGreen,
      appBar: MyAppBar(searchController: _searchController,),
       body: BlocBuilder<RepositoryCubit, RepositoryState>(
        builder: (context, state) {
          if (state is RepositoryLoading && state.repositories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RepositoryLoaded || (state is RepositoryLoading && state.repositories.isNotEmpty)) {
            final repositories = state is RepositoryLoading ? state.repositories : (state as RepositoryLoaded).repositories;
            return RefreshIndicator(
              onRefresh: () => context.read<RepositoryCubit>().refreshRepositories(),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.hasMore ? repositories.length + 1 : repositories.length,
                itemBuilder: (context, index) {
                  if (index >= repositories.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final repo = repositories[index];
                  return ListContainer(repository: repo);
                },
              ),
            );
          } else if (state is RepositoryError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ), );
  }
}