import Foundation

extension ObservableObject where Self: AnyObject {
    func performTask<T>(
        loadingKeyPath: ReferenceWritableKeyPath<Self, Bool>? = nil,
        operation: @escaping () async throws -> T,
        onSuccess: @escaping (T) -> Void = { _ in },
        onError: @escaping (Error) -> Void = { print("Error: \($0)") }
    ) {
        if let keyPath = loadingKeyPath {
            Task { @MainActor [weak self] in
                self?[keyPath: keyPath] = true
            }
        }
        
        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return }
            
            
            let taskResult: Result<T, Error>
            
            do {
                let result = try await operation()
                taskResult = .success(result)
            } catch {
                taskResult = .failure(error)
            }
            
            // ✅ 3. 모든 UI 업데이트를 한 번의 MainActor 호출로 처리
            await self.handleTaskCompletion(
                result: taskResult,
                loadingKeyPath: loadingKeyPath,
                onSuccess: onSuccess,
                onError: onError
            )
        }
    }
    
    @MainActor
    private func handleTaskCompletion<T>(
        result: Result<T, Error>,
        loadingKeyPath: ReferenceWritableKeyPath<Self, Bool>?,
        onSuccess: @escaping (T) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        // 로딩 상태 해제
        if let keyPath = loadingKeyPath {
            self[keyPath: keyPath] = false
        }
        
        // 결과 처리
        switch result {
        case .success(let value):
            onSuccess(value)
        case .failure(let error):
            onError(error)
        }
    }
}
