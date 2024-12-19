import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pets_shop/core/constants/constants.dart';
import 'package:pets_shop/core/globals/globals.dart';
import 'package:pets_shop/features/pets/screens/card.dart';

import '../../../models/pet_model.dart';
import 'add_pet.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  List<PetModel> pets = [];

  Future<void> fetchPetDetails() async {
    fetched = false;
    setState(() {});
    const url = 'https://valamcars.rankuhigher.in/api/get/form';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      pets = List.generate(jsonResponse['data'].length,
          (index) => PetModel.fromJson(jsonResponse['data'][index]));
      setState(() {});
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch pet details')),
        );
      }
    }
    fetched = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPetDetails();
  }

  bool fetched = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            fetched == false
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : pets.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                ImageConstants.noPets,
                                width: 250,
                                height: 250,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Opps! your pet list is empty",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: pets.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.8),
                            itemBuilder: (context, index) {
                              var pet = pets[index];
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffE8E8E8),
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                            height: 125,
                                            child: CustomContainer(
                                                url: pet.image)),
                                        Positioned(
                                          top: 6,
                                          right: 6,
                                          child: InkWell(
                                            onTap: () {
                                              if (favourites.contains(pet.id)) {
                                                favourites.remove(pet.id);
                                              } else {
                                                favourites.add(pet.id);
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 30,
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE9E9E9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Transform.scale(
                                                scale: 1.5,
                                                child: Image.asset(
                                                  ImageConstants.likeIcon,
                                                  color: favourites
                                                          .contains(pet.id)
                                                      ? Colors.pink
                                                      : Colors.white,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: SvgPicture.asset(
                                            pet.gender == "Female"
                                                ? ImageConstants.femaleIcon
                                                : ImageConstants.maleIcon,
                                            width: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pet.petName,
                                          style: const TextStyle(
                                              fontFamily: "SfProMedium"),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              ImageConstants.locationIcon,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            SizedBox(
                                              width: 10,
                                              child: Text(
                                                pet.location,
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "SfProRegular"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPetScreen(),
                      ));

                  if (result == true) {
                    // 'true' indicates a new pet was added
                    fetchPetDetails();
                  }
                },
                icon: SvgPicture.asset(
                  ImageConstants.addIcon,
                  width: 20,
                ),
                label: Text(
                  "Add New Pet",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDD835),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
