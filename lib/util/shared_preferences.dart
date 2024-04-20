import 'package:oasis_uz_mobile/repositories/models/cottage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String favoriteCottageIdsKey = 'favoriteCottageIds';

  static Future<Set<int>?> loadFavoriteCottageIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<int>? storedIds = prefs
        .getStringList(favoriteCottageIdsKey)
        ?.map((id) => int.parse(id))
        .toSet();
    return storedIds;
  }

  static List<Cottage> changeFavorite(
      List<Cottage> cottageList, Set<int>? favoriteList) {
    if (favoriteList == null) {
      for (var cottage in cottageList) {
        cottage.isFavorite = false;
      }
      return cottageList;
    }
    for (Cottage cottage in cottageList) {
      if (favoriteList.contains(cottage.id)) {
        cottage.isFavorite = true;
      } else {
        cottage.isFavorite = false;
      }
    }

    return cottageList;
  }

  static Future<void> saveFavoriteCottageIds(
      Set<int> favoriteCottageIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favoriteCottageIdsKey,
        favoriteCottageIds.map((id) => id.toString()).toList());
  }
}
