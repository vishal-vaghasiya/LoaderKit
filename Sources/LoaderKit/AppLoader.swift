import SwiftUI

@MainActor
public final class AppLoader: ObservableObject {

    // MARK: - Singleton

    public static let shared = AppLoader()

    private init() {}

    // MARK: - Published State

    /// Indicates whether a loader overlay is currently visible.
    @Published public private(set) var isLoader: Bool = false

    /// Current loader visual style.
    @Published public var style: LoaderStyle = .activity

    /// If true, loader does not block user interaction.
    @Published public var isSilent: Bool = false

    /// Message displayed in success overlay.
    @Published public var successMessage: String?

    /// Controls visibility of the success overlay.
    @Published public var showsSuccess: Bool = false

    /// Message displayed in error overlay.
    @Published public var errorMessage: String?

    /// Controls visibility of the error overlay.
    @Published public var showsError: Bool = false

    // MARK: - Internal State

    private var autoHideTask: Task<Void, Never>?

    // MARK: - Loader Controls

    /// Show loader using the current style (blocking).
    public func show() {
        isSilent = false
        isLoader = true
        scheduleAutoHide()
    }

    /// Show loader with a specific style (blocking).
    public func show(style: LoaderStyle) {
        self.style = style
        show()
    }

    /// Show loader without blocking UI interaction.
    public func showSilent(style: LoaderStyle = .activity) {
        self.style = style
        isSilent = true
        isLoader = true
        scheduleAutoHide()
    }

    /// Hide loader immediately and cancel auto-hide.
    public func hide() {
        autoHideTask?.cancel()
        autoHideTask = nil
        isLoader = false
        isSilent = false
    }

    // MARK: - Async Helper

    /// Executes an async operation while automatically managing the loader lifecycle.
    @MainActor
    public func withLoader<T>(
        _ operation: @escaping () async throws -> T
    ) async rethrows -> T {
        show()
        defer { hide() }
        return try await operation()
    }

    // MARK: - Success Overlay

    /// Shows a success overlay with an icon and message.
    /// - Parameters:
    ///   - message: Success text to display.
    ///   - delay: Auto-hide delay in seconds.
    ///   - completion: Optional callback after success overlay hides.
    public func showSuccess(
        message: String,
        autoHideAfter delay: TimeInterval = 2.0,
        completion: (() -> Void)? = nil
    ) {
        hide()
        // Ensure error overlay is not visible
        errorMessage = nil
        showsError = false

        successMessage = message
        showsSuccess = true

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            hideSuccess()
            completion?()
        }
    }

    /// Hides the success overlay immediately.
    public func hideSuccess() {
        successMessage = nil
        showsSuccess = false
    }

    // MARK: - Error Overlay

    /// Shows an error overlay with an icon and message.
    /// - Parameters:
    ///   - message: Error text to display.
    ///   - delay: Auto-hide delay in seconds.
    public func showError(
        message: String,
        autoHideAfter delay: TimeInterval = 2.0
    ) {
        hide()
        // Ensure success overlay is not visible
        successMessage = nil
        showsSuccess = false

        errorMessage = message
        showsError = true

        Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            hideError()
        }
    }

    /// Hides the error overlay immediately.
    public func hideError() {
        errorMessage = nil
        showsError = false
    }

    // MARK: - Auto Hide

    /// Automatically hides the loader after a timeout to prevent stuck states.
    private func scheduleAutoHide(timeout: TimeInterval = {
        #if DEBUG
        return 5
        #else
        return 30
        #endif
    }()) {
        autoHideTask?.cancel()
        autoHideTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
            hide()
        }
    }
}
