import 'package:geolocator/geolocator.dart';

extension BWPlacemark on Placemark {
  String toReadableString() {
    String s = "";
    if (thoroughfare.isNotEmpty) s += thoroughfare;
    if (subThoroughfare.isNotEmpty) {
      if (thoroughfare.isNotEmpty) s += " ";
      s += subThoroughfare;
    }
    if (s.isNotEmpty) s += ", ";
    if (s.isNotEmpty && postalCode.isNotEmpty) s += postalCode + " ";
    s += "$locality, $country";
    return s;
  }
}
