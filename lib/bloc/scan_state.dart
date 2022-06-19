import 'package:desktop_organizer/bloc/scan_data.dart';
import 'package:flutter/rendering.dart';

abstract class ScanState {
  const ScanState();
}

class ScanInit extends ScanState {
  const ScanInit();
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

class ScanStep extends ScanState {
  ScanData scanData;
  ScanStep({required this.scanData});
}

class ScanCompleted extends ScanState {
  Map data;
  ScanCompleted({required this.data});
}

class ScanFailed extends ScanState {
  const ScanFailed();
}
