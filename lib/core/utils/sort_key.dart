/// Builds a normalised key used to sort text the way people expect.
///
/// The key is lower case, has collapsed whitespace and ignores a leading
/// English article ("the", "a", "an"), so "The Beatles" sorts under B.
/// Returns null for null or blank input, so missing values can be sorted last.
String? buildSortKey(String? value) {
  if (value == null) return null;

  var key = value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  if (key.isEmpty) return null;

  for (final article in const ['the ', 'an ', 'a ']) {
    if (key.startsWith(article) && key.length > article.length) {
      key = key.substring(article.length);
      break;
    }
  }
  return key;
}
