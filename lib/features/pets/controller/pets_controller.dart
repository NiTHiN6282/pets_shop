import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pets_shop/core/utils/utils.dart';

import '../../../models/pet_model.dart';
import '../repository/pets_repository.dart';

final petsControllerProvider = NotifierProvider<PetsController, bool>(() {
  return PetsController();
});

final getPetsStreamProvider = FutureProvider<List<PetModel>>((ref) async {
  return ref.watch(petsControllerProvider.notifier).getPetsStream();
});

class PetsController extends Notifier<bool> {
  PetsRepository get _petsRepository => ref.read(petsRepositoryProvider);
  @override
  build() {
    return false;
  }

  addPet({
    required String gender,
    required File imageFile,
    required String location,
    required String ownerName,
    required String petName,
    required String petType,
    required BuildContext context,
  }) async {
    final res = await _petsRepository.addPet(
        gender: gender,
        imageFile: imageFile,
        location: location,
        ownerName: ownerName,
        petName: petName,
        petType: petType,
        context: context);

    res.fold((l) {
      showSnackBar(context, "Failed to add pet details");
    }, (r) {
      showSnackBar(context, r);
      Navigator.pop(context, true);
    });
  }

  Future<List<PetModel>> getPetsStream() async {
    return _petsRepository.getPetsStream();
  }
}
