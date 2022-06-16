enum PageType {
  homepage,
  anotherPage,
}

extension PageTypeInfo on PageType {
  String get pageName {
    switch (this) {
      case PageType.homepage:
        return "Homepage";
      case PageType.anotherPage:
        return "Example";
    }
  }
}

enum ItemType {
  folder,
  file,
}
