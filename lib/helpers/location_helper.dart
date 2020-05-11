const GOOGLE_API_KEY = 'AIzaSyAF_mSd6LscGy5pYbKr4g9pWsyKyZJFRD0';

class LocationHelper {
  static String generatePreview({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
