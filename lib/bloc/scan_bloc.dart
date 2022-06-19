import 'dart:developer';
import 'dart:io';

import 'package:desktop_organizer/bloc/scan_data.dart';
import 'package:desktop_organizer/bloc/scan_event.dart';
import 'package:desktop_organizer/bloc/scan_repository.dart';
import 'package:desktop_organizer/bloc/scan_state.dart';
import 'package:desktop_organizer/models/scanned_item.dart';
import 'package:desktop_organizer/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanRepository scanRepository;
  ScanBloc(this.scanRepository) : super(const ScanInit()) {
    on<ScanDirectory>(
      (event, emit) => _scanDirectory(event, emit),
    );
  }

  int total = 0;
  int current = 0;

  Future<void> _scanDirectory(
    ScanDirectory event,
    Emitter<ScanState> emit,
  ) async {
    emit(const ScanLoading());
    Directory root = Directory(event.directoryPath);
    var res = root.listSync(
      followLinks: false,
    );
    List<ScannedItem> items = [];
    for (var current in res) {
      items.add(
        ScannedItem(
          path: current.path,
          itemType: current is File ? ItemType.file : ItemType.folder,
          parent: current.parent,
        ),
      );
    }
    emit(
      ScanCompleted(
        data: {"scan": res},
      ),
    );
  }
}
