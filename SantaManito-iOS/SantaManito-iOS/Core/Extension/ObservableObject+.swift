import Foundation

extension ObservableObject where Self: AnyObject {

    
    func performTask<T>(
        loadingKeyPath: ReferenceWritableKeyPath<Self, Bool>? = nil,
        operation: @escaping () async throws -> T,
        onSuccess: @escaping @MainActor (T) -> Void = { _ in },
        onError: @escaping @MainActor (Error) -> Void = { print("Error: \($0)") }
    ) {
        Task {
            if let keyPath = loadingKeyPath {
                self[keyPath: keyPath] = true
            }

            defer {
                if let keyPath = loadingKeyPath {
                    self[keyPath: keyPath] = false
                }
            }

            do {
                let result = try await operation()
                await onSuccess(result)
            } catch {
                await onError(error)
            }
        }
    }
}
