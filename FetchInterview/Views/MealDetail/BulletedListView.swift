//
//  BulletedListView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-30.
//

import SwiftUI

/// `BulletListItemView` is a SwiftUI view that provides a bullet list item user interface.
/// This view includes a custom bullet point and a line of text.
///
/// - Parameters:
///   - text: The text to be displayed in the list item.
///   - bullet: The closure that generates the bullet point view.
///   - bulletColor: The color of the bullet point. Defaults to primary color.
///   - textColor: The color of the text. Defaults to primary color.
///   - font: The font of the text. Defaults to .body.
///   - lineLimit: The maximum number of lines for the text. If nil, no limit is set. Defaults to nil.
struct BulletListItemView<Content: View>: View {
    let text: String
    let bullet: () -> Content
    let textColor: Color
    let font: Font
    let lineLimit: Int?

    init(text: String,
         @ViewBuilder bullet: @escaping () -> Content = { Circle().frame(width: 6, height: 6).foregroundColor(.primary) },
         textColor: Color = .primary,
         font: Font = .body,
         lineLimit: Int? = nil) {
        self.text = text
        self.bullet = bullet
        self.textColor = textColor
        self.font = font
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        HStack(spacing: 8) {
            bullet()
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .lineLimit(lineLimit)
            Spacer()
        }
    }
}
