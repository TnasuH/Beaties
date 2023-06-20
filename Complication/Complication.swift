import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry()], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date = Date()
}

struct ComplicationEntryView : View {
    @Environment(\.widgetFamily) var family
    let entry: Provider.Entry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            switch family {
            case .accessoryInline: Text("120 mg/dL")
            case .accessoryCorner:
                Image("Complication").resizable()
                    .aspectRatio(contentMode: .fit)
            case .accessoryCircular:
                Image("Complication").resizable()
                    .aspectRatio(contentMode: .fit)
            case .accessoryRectangular:
                Text("foo")
            @unknown default:
                EmptyView()
            }
        }.widgetURL(URL(filePath: "/add"))
    }
}

@main
struct Complication: Widget {
    let kind: String = "Complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ComplicationEntryView(entry: entry)
        }
        .supportedFamilies([.accessoryCircular, .accessoryRectangular])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

@available(watchOS 10, *)
struct Complication_Previews: PreviewProvider {
    static var previews: some View {
        ComplicationEntryView(entry: SimpleEntry())
            .containerBackground(Color("Primary", bundle: .main), for: .widget)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
