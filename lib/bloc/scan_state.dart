import 'package:desktop_organizer/bloc/scan_data.dart';

class ScanCompleted extends ScanState {
  Map data;
  ScanCompleted({required this.data});
}

class ScanFailed extends ScanState {
  const ScanFailed();
}

class ScanInit extends ScanState {
  const ScanInit();
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

abstract class ScanState {
  const ScanState();
}

class ScanStep extends ScanState {
  ScanData scanData;
  ScanStep({required this.scanData});
}
