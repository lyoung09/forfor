class UserData {
  String _nickname;
  String _url;
  String _country;

  UserData(this._nickname, this._url, this._country);

  String get nickname => _nickname;
  String get url => _url;
  String get country => _country;
}
