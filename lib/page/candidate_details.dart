import 'dart:io';

import 'package:flutter/material.dart';
import 'candidates.dart';

class CandidateDetailsPage extends StatelessWidget {
  final Candidate candidate;

  const CandidateDetailsPage({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${candidate.name} ${candidate.surname}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${candidate.name} ${candidate.surname}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 320,
                  height: 300,
                  decoration: BoxDecoration(
                    image: candidate.imagePath.isNotEmpty
                        ? DecorationImage(
                      image: FileImage(File(candidate.imagePath)),
                      fit: BoxFit.cover,
                    )
                        : null,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            //Text('Birthdate: ${candidate.birthdate}'),
            Text('Description: ${candidate.bio}'),
          ],
        ),
      ),
    );
  }
}
