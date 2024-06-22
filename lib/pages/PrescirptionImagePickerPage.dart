import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharma_et/providers/PrescriptionImageProvider.dart';
import 'package:pharma_et/utils/ContextExtension.dart';
import 'package:pharma_et/utils/ImagePicker.dart';
import 'package:provider/provider.dart';

class PrescirptionImagePickerPage extends StatelessWidget {
  const PrescirptionImagePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<PrescriptionImageProvider>(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 32, right: 32, top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.localizations.pickPrescriptionPicture.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final res = await pickImageFromGallery();
                  res.fold((l) {}, (image) {
                    imageProvider.setPrescriptionImagePathAndName(
                      image.path,
                      image.name,
                    );
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image,
                        size: MediaQuery.of(context).size.width * 0.25),
                    Text(context.localizations.gallery)
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              GestureDetector(
                onTap: () async {
                  final res = await pickImageFromCamera();
                  res.fold((l) {}, (image) {
                    imageProvider.setPrescriptionImagePathAndName(
                      image.path,
                      image.name,
                    );
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera,
                        size: MediaQuery.of(context).size.width * 0.25),
                    Text(context.localizations.camera)
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          if (imageProvider.prescriptionImagePath != null) ...[
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Card(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(imageProvider.prescriptionImagePath!),
                      // height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(imageProvider.prescriptionImagePath!),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
          FilledButton(
            onPressed: imageProvider.prescriptionImageName != null
                ? () async {
                    imageProvider.toggleIsLoading();
                    final res = await imageProvider.uploadPresciptionImage();

                    imageProvider.toggleIsLoading();
                    res.fold((l) {
                      l.showError(context);
                    }, (r) {
                      r.showSuccess(context);
                      imageProvider.setPrescriptionImagePathAndName(null, null);
                      GoRouter.of(context)
                          .pushReplacementNamed("prescriptions");
                    });
                  }
                : null,
            child: imageProvider.isLoading
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(context.localizations.upload),
          ),
        ],
      ),
    );
  }
}
