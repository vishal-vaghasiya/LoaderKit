import SwiftUI

// MARK: - Success View

/// Displays a success message inside a HUD-style overlay.
/// Used by LoaderKit to present non-blocking success feedback.
struct SuccessView: View {

    // MARK: - Properties

    /// Success message to display.
    let message: String

    // MARK: - View

    var body: some View {
        HUDContainer {
            VStack(spacing: 12) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 42, weight: .medium))

                Text(message)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
