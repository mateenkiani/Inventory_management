class Singleton {
  int _activeNavItem;
  String _downloadUrl;

  Singleton._privateConstructor() {
    _activeNavItem = 0;
    _downloadUrl = '';
  }

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;

  void setActiveNavItem(int value) {
    _activeNavItem = value;
  }

  void setDownloadUrl(String value) {
    _downloadUrl = value;
  }

  int get activeItem => _activeNavItem;
  String get downloadUrl => _downloadUrl;
}
