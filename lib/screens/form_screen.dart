import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure "intl" is in your pubspec.yaml

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _selectedOption = 'Option 1';
  final List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

  DateTime? _selectedDate;
  bool _newsletter = false;
  double _sliderValue = 5.0;

  Future<void> _pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Text Field
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Dropdown
          DropdownButtonFormField<String>(
            value: _selectedOption,
            items: _options.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOption = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Choose an option',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Date Picker
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No date chosen'
                      : DateFormat.yMd().format(_selectedDate!),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _pickDate(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Switch
          SwitchListTile(
            title: const Text('Subscribe to newsletter'),
            value: _newsletter,
            onChanged: (bool value) {
              setState(() {
                _newsletter = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // Slider
          Text('Satisfaction level: ${_sliderValue.toStringAsFixed(0)}'),
          Slider(
            min: 0,
            max: 10,
            value: _sliderValue,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          const SizedBox(height: 16),

          // Submit Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Show results in a SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Form submitted:\nName: ${_nameController.text}\n'
                      'Option: $_selectedOption\nDate: $_selectedDate\n'
                      'Newsletter: $_newsletter\nSlider: $_sliderValue',
                    ),
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          // Left column
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedOption,
                  items: _options.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Choose an option',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen'
                            : DateFormat.yMd().format(_selectedDate!),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        _pickDate(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right column
          Expanded(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Subscribe to newsletter'),
                  value: _newsletter,
                  onChanged: (bool value) {
                    setState(() {
                      _newsletter = value;
                    });
                  },
                ),
                Text('Satisfaction: ${_sliderValue.toStringAsFixed(0)}'),
                Slider(
                  min: 0,
                  max: 10,
                  value: _sliderValue,
                  onChanged: (newValue) {
                    setState(() {
                      _sliderValue = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Form submitted:\nName: ${_nameController.text}\nOption: $_selectedOption',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
