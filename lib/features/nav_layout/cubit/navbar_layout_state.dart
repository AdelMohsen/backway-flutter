class NavbarLayoutState {
  final int currentIndex;

  const NavbarLayoutState({this.currentIndex = 0});

  NavbarLayoutState copyWith({int? currentIndex}) {
    return NavbarLayoutState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
