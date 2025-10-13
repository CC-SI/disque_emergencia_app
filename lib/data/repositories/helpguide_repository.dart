import '../models/helpguide_model.dart';
import '../providers/helpguide_provider.dart';
import 'package:collection/collection.dart';

class HelpRepository {
  final HelpGuideProvider _provider = HelpGuideProvider();

  Future<List<HelpGuide>> loadGuides() => _provider.loadGuides();

  Future<HelpGuide?> loadGuideById(int id) async {
    final guides = await loadGuides();
    return guides.firstWhereOrNull((g) => g.id == id);
  }

  Future<String> loadGuideContent(HelpGuide guide) async {
    return guide.content;
  }
}