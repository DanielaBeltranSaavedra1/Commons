import class Foundation.Bundle

private class BundleFinder {}

extension Foundation.Bundle {
  /// Returns the resource bundle associated with the current Swift module.
  static var module: Bundle { Bundle(for: BundleFinder.self) }
}
