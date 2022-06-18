enum PageType {
  scanner,
  virtualDesktop,
  realDesktop,
  typesDesktop,
}

extension PageTypeInfo on PageType {
  String get pageName {
    switch (this) {
      case PageType.scanner:
        return "Scanner";
      case PageType.virtualDesktop:
        return "Virtual Desktop";
      case PageType.realDesktop:
        return "Real Desktop";
      case PageType.typesDesktop:
        return "Types Dekstop";
    }
  }
}

enum ItemType {
  folder,
  file,
}

enum MouseMenuType {
  emptySlot,
  file,
  folder,
}
