enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}
