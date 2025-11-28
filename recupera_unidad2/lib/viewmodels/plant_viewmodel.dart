import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/plant.dart';

class PlantViewModel extends ChangeNotifier {
  List<Plant> _plants = [];
  bool _isLoading = false;
  String? _error;

  List<Plant> get plants => _plants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPlants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString('assets/plants.json');
      final data = json.decode(response);
      
      if (data is List) {
        _plants = data.map((json) => Plant.fromJson(json)).toList();
      } else if (data is Map && data['plants'] != null) {
        _plants = (data['plants'] as List)
            .map((json) => Plant.fromJson(json))
            .toList();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar las plantas: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}
