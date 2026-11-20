import 'package:ourtunes/features/library/domain/exclusion_rules.dart';

/// What a scan found and changed.
class ScanResult {
  const ScanResult({
    required this.filesOnDevice,
    required this.added,
    required this.updated,
    required this.restored,
    required this.markedMissing,
    required this.outsideFolders,
    required this.excluded,
  });

  static const ScanResult empty = ScanResult(
    filesOnDevice: 0,
    added: 0,
    updated: 0,
    restored: 0,
    markedMissing: 0,
    outsideFolders: 0,
    excluded: {},
  );

  final int filesOnDevice;
  final int added;
  final int updated;
  final int restored;
  final int markedMissing;

  /// Files skipped because they are outside the included folders.
  final int outsideFolders;

  /// Files skipped by the exclusion rules, counted per reason.
  final Map<ExclusionReason, int> excluded;

  int get excludedTotal => excluded.values.fold(0, (sum, value) => sum + value);

  String get summary {
    final buffer = StringBuffer('Found $filesOnDevice audio files. ');
    buffer.write(
      '$added new, $updated updated, $restored restored, $markedMissing missing.',
    );
    final skipped = <String>[
      for (final entry in excluded.entries)
        if (entry.value > 0) '${entry.value} ${entry.key.label}',
      if (outsideFolders > 0) '$outsideFolders outside included folders',
    ];
    if (skipped.isNotEmpty) {
      buffer.write(' Skipped: ${skipped.join(', ')}.');
    }
    return buffer.toString();
  }
}
