import 'package:shared_preferences/shared_preferences.dart';

class FavouritesSharedPreference {
  static const String key = "favourites_count";
  static const String itemKeyPrefix = "favourite_";

  static Future<void> saveFavourites(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();

    final count = prefs.getInt(key) ?? 0;
    for (int i = 0; i < count; i++) {
      prefs.remove("$itemKeyPrefix$i");
    }

    for (int i = 0; i < ids.length; i++) {
      prefs.setInt("$itemKeyPrefix$i", ids[i]);
    }
    prefs.setInt(key, ids.length);
  }

  static Future<List<int>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(key) ?? 0;

    List<int> ids = [];
    for (int i = 0; i < count; i++) {
      ids.add(prefs.getInt("$itemKeyPrefix$i") ?? -1);
    }
    return ids.where((id) => id != -1).toList();
  }

  static Future<void> addFavourite(int id) async {
    final favs = await getFavourites();
    if (!favs.contains(id)) {
      favs.add(id);
      await saveFavourites(favs);
    }
  }

  static Future<void> removeFavourite(int id) async {
    final favs = await getFavourites();
    favs.remove(id);
    await saveFavourites(favs);
  }

  static Future<bool> isFavourite(int id) async {
    final favs = await getFavourites();
    return favs.contains(id);
  }
}
