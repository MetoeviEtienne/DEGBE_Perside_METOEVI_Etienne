import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'candidates.dart';

class AddElectPage extends StatefulWidget {
  final Function(Candidate) addCandidate;

  const AddElectPage({required this.addCandidate, super.key});

  @override
  _AddElectPageState createState() => _AddElectPageState();
}

class _AddElectPageState extends State<AddElectPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _bio = '';
  File? _image;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      final candidate = Candidate(
        id: 0, // L'ID sera attribué par le serveur
        name: _name,
        surname: _surname,
        bio: _bio,
        imagePath: _image!.path,
        birthdate: DateFormat('yyyy-MM-dd').format(_selectedDate),
      );

      widget.addCandidate(candidate);

      Navigator.pop(context);
    } else if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mettez votre photo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Création de candidant'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Candidate image
                GestureDetector(
                  onTap: () async {
                    try {
                      await _pickImage(ImageSource.gallery);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to pick image: $e')),
                      );
                    }
                  },
                  child: Container(
                    width: 350,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: _image != null
                        ? Image.file(_image!)
                        : Icon(Icons.camera_alt, size: 50),
                  ),
                ),
                SizedBox(height: 16.0), // Adds space
                // Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrer votre nom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                SizedBox(height: 16.0), // Adds space
                // Surname
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prénom(s)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrer votre prénoms';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _surname = value!;
                  },
                ),
                SizedBox(height: 16.0), // Adds space
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefixIcon: Icon(Icons.book),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Entrer une description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _bio = value!;
                  },
                ),
                SizedBox(height: 16.0), // Adds space
                // Birthdate
                InkWell(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: IgnorePointer(
                    ignoring: true,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Birthdate',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      controller: TextEditingController(
                        text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                      ),
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((pickedDate) {
                          if (pickedDate != null && pickedDate != _selectedDate) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0), // Adds space
                // Add button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Valider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
