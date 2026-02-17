import SwiftUI

// MARK: - HUD Container

/// A reusable HUD-style container used for success and error overlays.
/// Displays centered content with a dimmed background and rounded card.
struct HUDContainer<Content: View>: View {

    // MARK: - Properties

    /// Content displayed inside the HUD card.
    let content: Content

    // MARK: - Initializer

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // MARK: - View

    var body: some View {
        ZStack {
            Color.black.opacity(0.25)
                .ignoresSafeArea()

            VStack {
                content
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 24)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
        }
    }
}
