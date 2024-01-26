// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pixal_lab_bloc/features/model/pixal_api_model.dart';

class PixelState {
  List<Photos> imgList = [];
  bool loading;
  String error;
  String nextUrl;

  PixelState(
      {this.imgList = const [],
      this.loading = true,
      this.error = "",
      this.nextUrl = ""});

  PixelState copyWith(
      {List<Photos>? imgList,
      bool? loading,
      String? error,
      String? nextUrl,
      Image? img}) {
    return PixelState(
      imgList: imgList ?? this.imgList,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      nextUrl: nextUrl ?? this.nextUrl,
    );
  }
}
