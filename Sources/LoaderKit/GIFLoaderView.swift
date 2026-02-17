import SwiftUI

struct GIFLoaderView: UIViewRepresentable {

    // MARK: - Properties

    /// Name of the GIF file (without extension) located in the main bundle.
    let gifName: String

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> GIFImageView {
        let imageView = GIFImageView(frame: .zero)
        imageView.loadGIF(named: gifName)
        return imageView
    }

    func updateUIView(_ uiView: GIFImageView, context: Context) {
        // No-op
    }
}
