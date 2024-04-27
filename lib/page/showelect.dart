import 'dart:io';

import 'package:devoir_ig2/page/addelected.dart';
import 'package:flutter/material.dart';
import 'candidates.dart';
import 'candidate_details.dart';

class ShowElectPage extends StatefulWidget {
  const ShowElectPage({super.key});

  @override
  _ShowElectPageState createState() => _ShowElectPageState();
}

class _ShowElectPageState extends State<ShowElectPage> {
  int _selectedIndex = 0;
  List<Candidate> _candidates = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addCandidate(Candidate candidate) {
    setState(() {
      _candidates.add(candidate);
      _isLoading = true;
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _candidates.length,
                itemBuilder: (context, index) {
                  final candidate = _candidates[index];
                  return Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CandidateDetailsPage(candidate: candidate),
                          ),
                        );
                      },
                      leading: Container(
                        width: 50,
                        height: 50,
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
                      title: Text('${candidate.name} ${candidate.surname}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description: ${candidate.bio}'),
                          Text('Birthdate: ${candidate.birthdate}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddElectPage(
                addCandidate: (candidate) => _addCandidate(candidate),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Person'),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Vote'),
                    style: TextButton.styleFrom(
                      // primary: Colors.black, // couleur du texte
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Settings'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
