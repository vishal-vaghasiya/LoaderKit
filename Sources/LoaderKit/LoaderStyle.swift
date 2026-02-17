//
//  LoaderStyle.swift
//  LoaderKit
//
//  Defines the visual styles supported by the global loader.
//

// MARK: - Loader Style

/// Represents the available loader visual styles in LoaderKit.
public enum LoaderStyle {

    // MARK: - System Styles

    /// System activity indicator using `ProgressView`.
    case activity

    /// Indeterminate circular ring loader (Apple-style).
    case ring

    // MARK: - Custom Styles

    /// Animated GIF loader.
    /// - Parameter name: GIF file name (without extension) located in the main bundle.
    case gif(name: String)
}
