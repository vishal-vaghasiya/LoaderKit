import UIKit
import ImageIO

/// A UIImageView subclass for displaying and animating GIF images.
final class GIFImageView: UIImageView {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Setup

    /// Common configuration for the GIF image view.
    private func commonInit() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }

    // MARK: - GIF Loader

    /// Loads and plays a GIF from the main bundle.
    /// - Parameter name: GIF file name without extension.
    func loadGIF(named name: String) {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "gif"),
            let data = try? Data(contentsOf: url),
            let source = CGImageSourceCreateWithData(data as CFData, nil)
        else {
            return
        }

        var images: [UIImage] = []
        var duration: TimeInterval = 0

        let count = CGImageSourceGetCount(source)

        for index in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, index, nil) else { continue }

            let frameDuration = frameDuration(at: index, source: source)
            duration += frameDuration

            images.append(UIImage(cgImage: cgImage))
        }

        animationImages = images
        animationDuration = duration
        animationRepeatCount = 0
        startAnimating()
    }

    // MARK: - Frame Timing

    /// Returns the display duration for a GIF frame.
    /// - Parameters:
    ///   - index: Frame index.
    ///   - source: Image source containing the GIF.
    /// - Returns: Frame duration in seconds.
    private func frameDuration(at index: Int, source: CGImageSource) -> TimeInterval {
        guard
            let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [CFString: Any],
            let gifInfo = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any]
        else {
            return 0.1
        }

        if let delay = gifInfo[kCGImagePropertyGIFUnclampedDelayTime] as? NSNumber {
            return delay.doubleValue
        }

        if let delay = gifInfo[kCGImagePropertyGIFDelayTime] as? NSNumber {
            return delay.doubleValue
        }

        return 0.1
    }
}
