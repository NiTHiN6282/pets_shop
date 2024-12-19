import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:pets_shop/core/utils/failure.dart';
import 'package:pets_shop/core/utils/type_defs.dart';
import 'package:pets_shop/models/pet_model.dart';

final petsRepositoryProvider = Provider<PetsRepository>((ref) {
  return PetsRepository();
});

class PetsRepository {
  PetsRepository();

  FutureVoid addPet({
    required String petName,
    required String ownerName,
    required String petType,
    required String gender,
    required String location,
    required File imageFile,
    required BuildContext context,
  }) async {
    var uri = Uri.parse('https://valamcars.rankuhigher.in/api/register/form');
    var request = http.MultipartRequest('POST', uri);

    request.fields['pet_name'] = petName;
    request.fields['user_name'] = ownerName;
    request.fields['pet_type'] = petType;
    request.fields['gender'] = gender;
    request.fields['location'] = location;

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      return right("");
    } else {
      return left(Failure(""));
    }
  }

  Future<List<PetModel>> getPetsStream() async {
    const url = 'https://valamcars.rankuhigher.in/api/get/form';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return List.generate(jsonResponse['data'].length,
          (index) => PetModel.fromJson(jsonResponse['data'][index]));
    } else {
      return [];
    }
  }
}
