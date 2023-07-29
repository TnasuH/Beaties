import SwiftUI

struct PrintHeaderRow: View {
    var body: some View {
        GridRow {
            Text("Date")
            Text("Time")
            Text("Glucose \(Text("(mg/dL)").font(.caption2))")
        }
        .gridColumnAlignment(.trailing)
        .font(.headline)
    }
}
