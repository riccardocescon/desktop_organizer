import 'package:desktop_organizer/bloc/scan_event.dart';
import 'package:desktop_organizer/bloc/scan_repository.dart';
import 'package:desktop_organizer/bloc/scan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanRepository scanRepository;
  ScanBloc(this.scanRepository) : super(const ScanInit()) {
    on<ScanDirectory>(
      (event, emit) => _scanDirectory(event, emit),
    );
  }

  Future<void> _scanDirectory(
    ScanDirectory event,
    Emitter<ScanState> emit,
  ) async {}
}
