import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pets_shop/core/utils.dart';

import '../../../core/constants/constants.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  String? selectedPetType;
  String? selectedGender;
  List<String> petTypes = ["Dog", "Cat", "Bird", "Fish"];
  List<String> genders = ["Male", "Female"];
  List<String> uploadedPhotos = [];

  final formkey = GlobalKey<FormState>();

  final TextEditingController petNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController additionalNoteController =
      TextEditingController();

  File? imageFile;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> addPetDetails() async {
    if (imageFile == null) {
      showSnackBar(context, "Please select an image");
      return;
    }
    add = true;
    setState(() {});

    var uri = Uri.parse('https://valamcars.rankuhigher.in/api/register/form');
    var request = http.MultipartRequest('POST', uri);

    request.fields['pet_name'] = petNameController.text;
    request.fields['user_name'] = ownerNameController.text;
    request.fields['pet_type'] = selectedPetType ?? "";
    request.fields['gender'] = selectedGender ?? "";
    request.fields['location'] = locationController.text;

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pet added successfully!')),
        );
        Navigator.pop(context, true);
      }

      clearForm();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add pet details')),
        );
      }
    }
    add = false;
    setState(() {});
  }

  bool add = false;

  void clearForm() {
    petNameController.clear();
    ownerNameController.clear();
    locationController.clear();
    selectedPetType = null;
    selectedGender = null;
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(ImageConstants.backButtonIcon),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text("Add your pet Detail",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "SfProMedium",
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet Name
                  Text(
                    "Your pet name",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      controller: petNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter pet name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "enter your pet name",
                        hintStyle: const TextStyle(color: Color(0xffB0B0B0)),
                        filled: true,
                        fillColor: const Color(0xffF9FAFB),

                        // Normal border
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 1.0,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 2.5,
                          ),
                        ),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.5,
                          ),
                        ),

                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.5,
                          ),
                        ),

                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Owner Name
                  Text(
                    "Your pet owner name",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      controller: ownerNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter pet owner name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "enter your pet owner name",
                        hintStyle: const TextStyle(color: Color(0xffB0B0B0)),
                        filled: true,
                        fillColor: const Color(0xffF9FAFB),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 1.0, // Border width
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.5, // Border width
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 2.5,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Type of Pet",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedPetType,
                    validator: (value) {
                      if (value == null) {
                        return "Select Pet Type";
                      }
                      return null;
                    },
                    hint: const Text("ex. dog"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: petTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPetType = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF9FAFB),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  Text(
                    "Gender",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    hint: const Text("ex. male"),
                    validator: (value) {
                      if (value == null) {
                        return "Select Pet Type";
                      }
                      return null;
                    },
                    items: genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF9FAFB),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "Enter pet location",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 55,
                    child: TextFormField(
                      controller: locationController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter location";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "enter your pet location",
                        hintStyle: const TextStyle(color: Color(0xffB0B0B0)),
                        filled: true, // Enables background color
                        fillColor: const Color(0xffF9FAFB), // Background color
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffEBECEF),
                            width: 2.5,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Additional Notes
                  Text(
                    "Additional Notes",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: additionalNoteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xffF9FAFB),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xffEBECEF),
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Upload Photos
                  Text(
                    "Add your pet profile picture and upload pet photos",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: DottedBorder(
                      padding: const EdgeInsets.all(20),
                      radius: const Radius.circular(30),
                      borderType: BorderType.RRect,
                      color: const Color(0xff494FDD),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Upload Photos",
                              style: GoogleFonts.inter(
                                color: const Color(0xff494FDD),
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset(ImageConstants.uploadIcon),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (imageFile != null)
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              imageFile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -20,
                          top: -11,
                          child: IconButton(
                            icon: SvgPicture.asset(ImageConstants.removeIcon),
                            onPressed: () {
                              setState(() {
                                imageFile = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Submit Button
                  add == true
                      ? const Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator()),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                addPetDetails();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFDD835),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
