  import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/repository.dart';

void showRepositoryDialog(BuildContext context, Repository repo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Open Link'),
          content: const Text('Do you want to open the repository or the owner\'s page?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchURL(repo.repoUrl);
              },
              child: const Text('Repository'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchURL(repo.ownerUrl);
              },
              child: const Text('Owner'),
            ),
          ],
        );
      },
    );
  }
   void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
