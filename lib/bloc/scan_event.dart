abstract class ScanEvent {
  const ScanEvent();
}

class ScanDirectory extends ScanEvent {
  String directoryPath;
  ScanDirectory({required this.directoryPath});
}
