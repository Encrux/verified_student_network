import 'package:verified_student_network/character_summary.dart';

class CharacterListingState {
  CharacterListingState({
    this.itemList,
    this.error,
    this.nextPageKey = 0,
  });

  final List<CharacterSummary>? itemList;
  final dynamic error;
  final int? nextPageKey;
}
