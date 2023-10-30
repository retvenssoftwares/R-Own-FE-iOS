//
//  KeybaordStateManager.swift
//  R-own
//
//  Created by Aman Sharma on 29/07/23.
//

//import Combine
//import SwiftUI
//
//class KeyboardStateManager: ObservableObject {
//    @Published var isKeyboardShowing: Bool = false
//    
//    private var cancellables: Set<AnyCancellable> = []
//    
//    init() {
//        registerForKeyboardEvents()
//    }
//    
//    private func registerForKeyboardEvents() {
//        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
//            .map { notification -> Bool in
//                if notification.name == UIResponder.keyboardWillShowNotification {
//                    return true
//                } else {
//                    return false
//                }
//            }
//            .assign(to: \.isKeyboardShowing, on: self)
//            .store(in: &cancellables)
//    }
//}



//struct KeybaordStateManager_Previews: PreviewProvider {
//    static var previews: some View {
//        KeybaordStateManager()
//    }
//}
