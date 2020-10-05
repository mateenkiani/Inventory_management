class Singleton {
  int _activeNavItem;

  Singleton._privateConstructor() {
    _activeNavItem = 0;
  }

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;

  void setActiveNavItem(int value) {
    _activeNavItem = value;
  }

  int get activeItem => _activeNavItem;
}
