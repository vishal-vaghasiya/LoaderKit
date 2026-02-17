import SwiftUI

// MARK: - Error View

/// Displays an error message inside a HUD-style overlay.
/// Used by LoaderKit to present non-blocking error feedback.
struct ErrorView: View {

    // MARK: - Properties

    /// Error message to display.
    let message: String

    // MARK: - View

    var body: some View {
        HUDContainer {
            VStack(spacing: 12) {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 42, weight: .medium))

                Text(message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
