import 'package:flutter/cupertino.dart';
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
        margin: const EdgeInsets.all(16),
               decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: repository.isFork ? Colors.white : ColorPalette.lightGreen,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElementRow(title: "Repo name : ",text: repository.name,), 
            const SizedBox(
              height: 5,
            ),
            ElementRow(title: "Description : ",text: repository.description,), 
            const SizedBox(
              height: 5,
            ),
            ElementRow(title: "Owner : ",text: repository.owner,), 
               ],
        ),
      ),
    );
  }
}

class ElementRow extends StatelessWidget {
  const ElementRow({
    super.key,
     required this.title, required this.text,
  });

     final String title;
   final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Text(
          title,
          style: const TextStyle(color:Colors.amber, fontSize: 16),
        ),
        Expanded(
          child: Text(
           text,
           overflow: TextOverflow.ellipsis,
                maxLines: 1,
            style:TextStyle(
              color:ColorPalette.lightbrown ,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}