// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/repository/students_repository.dart';

import '../../repository/teachers_repository.dart';

class CustomDownloadButton extends StatefulWidget {
  final ChangeNotifierProvider<dynamic> changeNotifierProvider;

  const CustomDownloadButton({
    Key? key,
    required this.changeNotifierProvider,
  }) : super(key: key);

  @override
  State<CustomDownloadButton> createState() => _CustomDownloadButtonState();
}

class _CustomDownloadButtonState extends State<CustomDownloadButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return isLoading
            ? const CircularProgressIndicator()
            : IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  try {
                    checkIsLoadingStatus();
                    checkDownloadProviderName(ref);
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  } finally {
                    checkIsLoadingStatus();
                  }
                },
              );
      },
    );
  }

  Future<void> checkDownloadProviderName(WidgetRef ref) async {
    String checkProviderName =
        widget.changeNotifierProvider.toString().split('#').first;
    checkProviderName == "ChangeNotifierProvider<TeachersRepository>"
        ? await ref.read(teachersProvider).download()
        : await ref.read(studentProvider).download();
  }

  void checkIsLoadingStatus() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
