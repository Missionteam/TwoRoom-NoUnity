import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class Versions {
  Versions({required this.version});
  final int version;
}

class VersionsNotifier extends StateNotifier<Versions> {
  VersionsNotifier() : super(Versions(version: 0));

  void setVersions(version) {
    state = Versions(version: version);
  }
}

final versionsProvider =
    StateNotifierProvider<VersionsNotifier, Versions>((ref) {
  return VersionsNotifier();
});
