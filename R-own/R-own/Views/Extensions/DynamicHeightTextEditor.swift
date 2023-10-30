//
//  DynamicHeightTextEditor.swift
//  R-own
//
//  Created by Aman Sharma on 22/07/23.
//

import SwiftUI

struct DynamicHeightTextEditor: View {
    @Binding var text: String
    @Binding var height: CGFloat

    var body: some View {
        TextEditor(text: $text)
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ContentSizeKey.self, value: geometry.size)
                }
            )
            .onPreferenceChange(ContentSizeKey.self) { newSize in
                height = newSize.height
            }
    }
}

struct ContentSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

//
//struct DynamicHeightTextEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        DynamicHeightTextEditor()
//    }
//}
