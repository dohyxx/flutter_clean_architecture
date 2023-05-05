import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhotosController extends GetxController{

  final _formKey = GlobalKey<FormState>();
  final _query = ''.obs;
  final _searchInitialized = false.obs;
  final _showErrorScreen = false.obs;

  GlobalKey<FormState> get formKey => _formKey;
  bool get searchInitialized => _searchInitialized.value;
  bool get showErrorScreen => _showErrorScreen.value;


  @override
  void onInit() {
    super.onInit();
  }

}