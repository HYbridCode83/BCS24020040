import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Required for Cupertino pickers

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  // State variables for the Pickers
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Gryffindor';

  // 1. Material Date Picker Function
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker Function with "Done" Button
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 280,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            // Header with Done Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Picker body
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Cupertino Wheel Picker Function with "Done" Button
  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'];
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 260,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            // Header with Done Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Picker body
            SizedBox(
              height: 180,
              child: CupertinoPicker(
                itemExtent: 32,
                scrollController: FixedExtentScrollController(
                  initialItem: roles.indexOf(_selectedRole),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedRole = roles[index]);
                },
                children: roles.map((role) => Center(child: Text(role))).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // --- PORTRAIT VIEW ---
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Lab 01 Profile Card with Quote
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.indigo,
                  backgroundImage: AssetImage('images/student.jpg'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'LIEW HENG YI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Student ID: BCS24020040',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Divider(height: 32, thickness: 1),
                const Text(
                  'Personal Life Goal / Quote:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '"Never Give Up"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Deconstructed Title Section + Hometown Image Card
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              const TitleSection(
                name: 'Hogwarts School of Witchcraft and Wizardry',
                location: 'Hogsmeade, Scotland',
                starCount: 41,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'images/hometown.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Interactive Pickers Section (Lab 02)
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Pickers (Lab 02)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Selected Date: ${_selectedDate.toString().split(' ')[0]}'),
                Text('Selected House: $_selectedRole'),
                const Divider(),

                ElevatedButton.icon(
                  onPressed: () => _selectMaterialDate(context),
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Material Date Picker'),
                ),
                const SizedBox(height: 8),

                OutlinedButton.icon(
                  onPressed: () => _showCupertinoDatePicker(context),
                  icon: const Icon(Icons.ios_share),
                  label: const Text('Cupertino Date Picker (Sheet)'),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Material Dropdown:'),
                    DropdownButton<String>(
                      value: _selectedRole,
                      items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                          .map((String role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => _selectedRole = newValue);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                OutlinedButton.icon(
                  onPressed: () => _showCupertinoRolePicker(context),
                  icon: const Icon(Icons.settings_applications),
                  label: const Text('Cupertino House Wheel Picker'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- LANDSCAPE VIEW ---
  Widget _buildLandscapeView() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.indigo,
                        backgroundImage: AssetImage('images/student.jpg'),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'LIEW HENG YI',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Student ID: BCS24020040',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Divider(height: 24),
                      const Text(
                        '"Never Give Up"',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const TitleSection(
                      name: 'Kuching',
                      location: 'Sarawak, Malaysia',
                      starCount: 41,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/hometown.jpg',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Interactive Pickers (Lab 02)',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Selected Date: ${_selectedDate.toString().split(' ')[0]}'),
                      Text('Selected House: $_selectedRole'),
                      const Divider(),
                      ElevatedButton.icon(
                        onPressed: () => _selectMaterialDate(context),
                        icon: const Icon(Icons.calendar_today),
                        label: const Text('Material Date Picker'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _showCupertinoDatePicker(context),
                        icon: const Icon(Icons.ios_share),
                        label: const Text('Cupertino Date Picker (Sheet)'),
                      ),
                      DropdownButton<String>(
                        value: _selectedRole,
                        items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                            .map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _selectedRole = newValue);
                          }
                        },
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _showCupertinoRolePicker(context),
                        icon: const Icon(Icons.settings_applications),
                        label: const Text('Cupertino House Wheel Picker'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Deconstructed Widget ---
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}