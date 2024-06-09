import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_cubit.dart';
import 'package:flutter_task/features/home/presentation/widgets/appbar.dart';

import '../../../../core/common/colors.dart';
import '../controller/cubit/repository_state.dart';
import '../widgets/list_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.deepGreen,
      appBar: const MyAppBar(),
       body: BlocBuilder<RepositoryCubit, RepositoryState>(
        builder: (context, state) {
          if (state is RepositoryInitial) {
            context.read<RepositoryCubit>().loadRepositories();
            return const Center(child: CircularProgressIndicator());
          } else if (state is RepositoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RepositoryLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<RepositoryCubit>().refreshRepositories(),
              child: ListView.builder(
                itemCount: state.repositories.length,
                itemBuilder: (context, index) {
                  final repo = state.repositories[index];
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
      ),
    );
  }
}