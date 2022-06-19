import 'package:desktop_organizer/bloc/scan_data.dart';

abstract class ScanRepository {
  Future<ScanData> _scanDirectory(String directoryPath);
}

class ScanWindowsRepo extends ScanRepository {
  @override
  Future<ScanData> _scanDirectory(String directoryPath) async {
    await Future.delayed(const Duration(seconds: 3));
    return ScanData(path: "path");
  }
}
