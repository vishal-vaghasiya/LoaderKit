import SwiftUI

// MARK: - Loader View

/// Renders the visual loader overlay based on the selected `LoaderStyle`.
/// This view is internal to LoaderKit and should not be used directly.
struct LoaderView: View {

    // MARK: - Properties

    /// Current loader style to render.
    let style: LoaderStyle

    /// Indicates whether the loader should block user interaction.
    let isSilent: Bool

    // MARK: - Initializer

    init(style: LoaderStyle, isSilent: Bool = false) {
        self.style = style
        self.isSilent = isSilent
    }

    // MARK: - View

    var body: some View {
        ZStack {
            if !isSilent {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
            }

            loaderContent
        }
    }

    // MARK: - Loader Content

    /// Returns the appropriate loader UI based on the current style.
    @ViewBuilder
    private var loaderContent: some View {
        switch style {
        case .activity:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.4)

        case .ring:
            RingLoaderView()
                .frame(width: 70, height: 70)

        case .gif(let name):
            GIFLoaderView(gifName: name)
                .frame(width: 70, height: 70)
        }
    }
}
