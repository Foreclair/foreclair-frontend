import 'package:flutter/material.dart';

abstract class LogbookInput<T> extends Widget {
  const LogbookInput({super.key});

  T? getValue();
}
