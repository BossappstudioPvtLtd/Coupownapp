import 'dart:io';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';  // For formatting the date

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGender, _selectedDate;
  final List<String> _genders = ['Male', 'Female'];

  Future<void> _pickImage() async {final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _imageFile = File(pickedFile.path));
  }

 Future<void> _selectDate(BuildContext context) async {
  final pickedDate = await showDatePicker(context: context,
    initialDate: DateTime.now(), firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme( data: ThemeData(colorScheme: const ColorScheme.light(
            primary: appColorAccent, // Header background color
            onPrimary: appColorPrimary, // Header text color
            surface: appColorPrimary, // Background color
            onSurface: Colors.black, // Text color
          ),
          dialogBackgroundColor: appColorPrimary, 
        ),
        child: child!,
      );
    },
  );
    if (pickedDate != null) { setState(() { _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);});}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
            const Padding( padding: EdgeInsets.only(left: 10,top: 20),child: MyAppbar(text: "Fill Your Profile"),),
            Padding( padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                  child: Column(children: [
                      const SizedBox(height: 20),
                      Center( child: Stack(children: [
                       CircleAvatar(radius: 50,  backgroundImage: _imageFile != null ? FileImage(_imageFile!) as ImageProvider<Object> : const NetworkImage('https://via.placeholder.com/150') as ImageProvider<Object>,),
                    
                            
             Positioned( bottom: 0, right: 0,
                            child: GestureDetector( onTap: _pickImage,child: Container( padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: appColorAccent, borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: const Icon(Icons.edit, size: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      const SizedBox(height: 20),
                      _buildTextField(_nameController, "Name"),
                      const SizedBox(height: 10),
                      _buildTextField(_emailController, "Email"),
                      const SizedBox(height: 10),
                      _buildDatePicker(context),
                      const SizedBox(height: 10),
                      _buildGenderDropdown(),
                      const SizedBox(height: 50),
                      SmallButton(elevationsize: 10, text: "Save",containerheight: 40,
                      onTap: () {  print('Name: ${_nameController.text}, Email: ${_emailController.text}, '
                                'Gender: ${_selectedGender ?? 'Not Selected'}, DOB: ${_selectedDate ?? 'Not Selected'}');
                    
                      },),
                     
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Card( elevation: 5,shadowColor: appColorPrimary,  color: appColorPrimary,
      child: Padding(padding: const EdgeInsets.only(left: 10),
        child: TextField(controller: controller,decoration: InputDecoration( border: InputBorder.none, enabledBorder: InputBorder.none,hintText: hint,)   
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Card(elevation: 5, shadowColor: appColorPrimary,color: appColorPrimary,
      child: Padding( padding: const EdgeInsets.only(left: 10),
        child: GestureDetector( onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(decoration: const InputDecoration(hintText: 'Date of Birth',border: InputBorder.none, enabledBorder: InputBorder.none,),
              controller: TextEditingController(text: _selectedDate ?? ''),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Card(elevation: 5, shadowColor: appColorPrimary, color: appColorPrimary,
      
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 20),
          child: DropdownButtonFormField<String>(value: _selectedGender,
          dropdownColor: appColorPrimary,borderRadius: BorderRadius.circular(8),
            items: _genders.map((String gender) { return DropdownMenuItem<String>(value: gender, child: Text(gender),alignment: Alignment.centerLeft);}).toList(),
            onChanged: (newValue) => setState(() => _selectedGender = newValue),
            decoration: const InputDecoration(hintText: "Gender",border: InputBorder.none,enabledBorder: InputBorder.none,),
          ),
        ),
      
    );
  }
}
