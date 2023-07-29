import SwiftUI

struct EntryLayout: Layout {
    private static let rowCount = 4
    private static let columnCount = 3
    private static let horizontalSpacing = CGFloat(2)
    private static let verticalSpacing = CGFloat(3)

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let size = proposal.replacingUnspecifiedDimensions()
        return size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var buttons = subviews
        let text = buttons.removeFirst()
        let textSize = text.sizeThatFits( .unspecified)

        let (textArea, buttonArea) = bounds.divided(atDistance: textSize.height, from: .minYEdge)
        text.place(at: textArea.center, anchor: .center, proposal: .init(textArea.size))

        let buttonWidth = (buttonArea.width - (CGFloat(Self.columnCount - 1) * Self.horizontalSpacing)) / CGFloat(Self.columnCount)
        let buttonHeight = (buttonArea.height - (CGFloat(Self.rowCount - 1) * Self.verticalSpacing)) / CGFloat(Self.rowCount)

        for index in 0..<buttons.count {
            let row = index / Self.columnCount
            let column = index % Self.columnCount

            let subview = buttons[index]
            let x = CGFloat(column) * (buttonWidth + Self.horizontalSpacing)
            let y = CGFloat(row) * (buttonHeight + Self.verticalSpacing) + textSize.height
            let point = CGPoint(x: x, y: y)
            subview.place(at: point, anchor: .topLeading, proposal: ProposedViewSize(width: buttonWidth, height: buttonHeight))
        }
    }
}
