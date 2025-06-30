//
//  ObservableObject+.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 6/30/25.
//

import Foundation

extension ObservableObject where Self: AnyObject { // ObservableObject를 따르고, **클래스 타입인 객체(ViewModel)**만 확장 대상으로 지정
    
    @MainActor
    func withLoading<T>(
        loadingKeyPath: ReferenceWritableKeyPath<Self, Bool>,
        operation: @escaping () async throws -> T
    ) async throws -> T {
        self[keyPath: loadingKeyPath] = true
        defer { self[keyPath: loadingKeyPath] = false } // defer 블록을 이용해 성공/실패 여부와 상관없이 로딩 상태를 false로 복원
        
        return try await operation()
    }
    
    @MainActor
    func performTask<T>(
        loadingKeyPath: ReferenceWritableKeyPath<Self, Bool>,
        operation: @escaping () async throws -> T,
        onSuccess: @escaping (T) -> Void = { _ in },
        onError: @escaping (Error) -> Void = { print("Error: \($0)") }
    ) {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let result = try await self.withLoading(
                    loadingKeyPath: loadingKeyPath,
                    operation: operation
                )
                onSuccess(result)
            } catch {
                onError(error)
            }
        }
    }
    
    @MainActor
    func performTask<T>(
        operation: @escaping () async throws -> T,
        onSuccess: @escaping (T) -> Void = { _ in },
        onError: @escaping (Error) -> Void = { print("Error: \($0)") }
    ) {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                let result = try await operation()
                onSuccess(result)
            } catch {
                onError(error)
            }
        }
    }
}
