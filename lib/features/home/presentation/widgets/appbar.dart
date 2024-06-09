import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_cubit.dart';

import '../../../../core/common/colors.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _AppBarState();
  
  @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.deepGreen,
        title: const Text('GitHub Repos' , style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh , color: Colors.white,),
            onPressed: () {
              context.read<RepositoryCubit>().refreshRepositories();
            },
          ),
        ],
      );
  }
}