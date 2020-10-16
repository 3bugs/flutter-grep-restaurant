import 'package:flutter/material.dart';

class ResponseResult {
  final bool success;
  final dynamic data;

  ResponseResult({
    @required this.success,
    @required this.data,
  });
}
