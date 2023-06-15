import HealthConnect
import SwiftUI

struct LatestEntryText: View {
    private let latestEntry: GlucoseSample?
    init(_ latestEntry: GlucoseSample?) {
        self.latestEntry = latestEntry
    }

    var body: some View {
        Text("\(valueText) \(unitText)")
    }

    private var valueText: Text {
        let value = switch latestEntry {
        case .none: "--"
        case .some(let sample): "\(sample.value.formatted(.number))"
        }
        return Text(value).font(.system(size: 42, weight: .black))
    }

    private var unitText: Text {
        Text("mg/dL").font(.body).fontWeight(.black)
    }
}

enum LatestEntryTextPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            LatestEntryText(nil)
            LatestEntryText(GlucoseSample(id: UUID(), value: 120, date: Date()))
            LatestEntryText(GlucoseSample(id: UUID(), value: 90, date: Date()))
        }
    }
}
