//
//  BaseViewModel.swift
//  Hayak
//
//  Created by wecancity on 08/12/2024.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    init() {
        print("BaseViewModel initialized")
    }
    func handleAPI<T: Codable>(
        target: TargetType,
        responseType: T.Type,
        onSuccess: @escaping (T?) -> Void,
        onFailure: ((NetworkError) -> Void)? = nil
    ) {
        BaseNetwork.shared.CallApi(target, BaseResponse<T>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
//                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    onFailure?(error)
                case .finished:
                    break
                }
            }, receiveValue: { response in
//                guard let self = self else { return }
                if response.success ?? false {
                    onSuccess(response.data)
                } else {
                    onFailure?(.unknown(code: response.messageCode ?? 0, error: response.message ?? "Unexpected error occurred"))
                }
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        print("BaseViewModel deinitialized")
    }
    
//        func cleanup() {
//            // Cancel any ongoing Combine subscriptions
//            cancellables.forEach { cancellable in
//                cancellable.cancel()
//            }
//            cancellables.removeAll()
//        }
}

