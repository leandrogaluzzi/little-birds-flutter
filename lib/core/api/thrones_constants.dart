import 'credentials.dart';

class ThronesConstants {
  static const baseURL = 'thronesdb.com';
  //static const baseURL = 'sandbox.thronesdb.com';

  static const cardsURL = '/api/public/cards/';
  static const packsURL = '/api/public/packs/';
  static const decksURL = '/api/public/decklists/by_date/';

  static const userDecksURL = '/api/oauth2/decks';

  static const authURL = '/oauth/v2/token';

  static const clientID = YOUR_CLIENT_ID;
  static const secretID = YOUR_SECRET_ID;
  static const redirect = 'littlebirds://thronesdb';

  static codeURL() {
    return 'https://' +
        baseURL +
        '/oauth/v2/auth?client_id=$clientID&response_type=code&redirect_uri=$redirect';
  }
}
