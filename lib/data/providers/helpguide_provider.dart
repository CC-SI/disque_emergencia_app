import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/helpguide_model.dart';

class HelpGuideProvider {
  Future<List<HelpGuide>> loadGuides() async {
    final String response = await rootBundle.loadString('lib/assets/data/helpguides.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => HelpGuide.fromJson(e)).toList();
  }
}