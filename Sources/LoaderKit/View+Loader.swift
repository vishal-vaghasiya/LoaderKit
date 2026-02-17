import SwiftUI

// MARK: - View Loader Extension

/// Provides a convenience API to attach the LoaderKit
/// global loader overlay to any SwiftUI view.
public extension View {

    // MARK: - Loader Attachment

    /// Attaches the LoaderKit global loader overlay to the view.
    ///
    /// Call this once at the root of a screen to enable
    /// global loader presentation.
    func withLoader() -> some View {
        modifier(LoaderModifier())
    }
}
