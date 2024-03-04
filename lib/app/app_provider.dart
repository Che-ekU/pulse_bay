import 'package:flutter/material.dart';
import 'package:pulse_bay_task/app/constants/assets.dart';
import 'package:pulse_bay_task/app/models/city.dart';
import 'package:pulse_bay_task/app/models/industry.dart';
import 'package:pulse_bay_task/app/models/trade.dart';
import 'package:pulse_bay_task/app/app_repository.dart';

class AppProvider extends ChangeNotifier {
  List<CitySchema> cities = [];
  List<IndustrySchema> industries = [];
  List<TradeSchema> searchResults = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> login() async {
    bool success = await AppRepository.login(
      email: emailController.text,
      passWord: passwordController.text,
    );
    emailController.clear();
    passwordController.clear();
    return success;
  }

  Future<List<CitySchema>> getCities() async {
    cities = await AppRepository.fetchCity();
    return cities;
  }

  Future<List<IndustrySchema>> getIndustries() async {
    industries = await AppRepository.fetchIndustries();
    return industries;
  }

  Future<List<TradeSchema>> getSearchResults() async {
    searchResults = await AppRepository.fetchTraders();
    return searchResults;
  }

  CitySchema? selectedCity;
  IndustrySchema? selectedIndustry;

  bool searchResultsSorted = false;

  void sortTrade() {
    searchResults.sort(
      (a, b) => ((a.businessName ?? '').toLowerCase())
          .compareTo((b.businessName ?? '').toLowerCase()),
    );
    if (searchResultsSorted) {
      searchResults = searchResults.reversed.toList();
    }
    searchResultsSorted = !searchResultsSorted;
    notify();
  }

  void notify() => notifyListeners();

  void resetSelection() {
    selectedCity = null;
    selectedIndustry = null;
    notifyListeners();
  }

  List<IndustrySchema> getTopSixIndustries() {
    return industries;
  }

  List<IndustrySchema> getMostViewedIndustries() {
    return industries;
  }

  List<String> randomSvg = [
    Assets.cleaning,
    Assets.electrician,
    Assets.painting,
    Assets.plumber,
    Assets.pestControl,
    Assets.salon,
  ];
}
