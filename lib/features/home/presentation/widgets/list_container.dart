import 'package:flutter/material.dart';
import 'package:flutter_task/core/common/colors.dart';
import 'package:flutter_task/features/home/domain/entities/repository.dart';
import 'package:flutter_task/features/home/presentation/widgets/repository_dialog.dart';

class ListContainer extends StatelessWidget {
  const ListContainer(
      {super.key,
       required this.repository,
      });
 final Repository repository;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: ()=> showRepositoryDialog(context, repository),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: repository.isFork ? Colors.white : ColorPalette.lightGreen,
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Repo Name: ',
                  style: TextStyle(color:Colors.amber, fontSize: 16),
                ),
                Text(
                  repository.name,
                  style:TextStyle(
                    color:ColorPalette.lightbrown ,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
               const Text(
                  'Repo Description: ',
                  style: TextStyle(color:Colors.amber, fontSize: 16),
                ),
                Text(
                  repository.description,
                  style: TextStyle(color:ColorPalette.lightbrown),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  'Created by: ',
                  style: TextStyle(color:Colors.amber, fontSize: 16),
                ),
                Text(
                  repository.owner,
                style: TextStyle(color:ColorPalette.lightbrown),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}