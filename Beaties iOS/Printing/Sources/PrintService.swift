import PhoneHealthConnect
import SwiftUI
import UIKit

public enum PrintService {
    @MainActor public static func print(repository: HealthRepository) async throws {
        let printController = UIPrintInteractionController.shared

        guard let mutableData = CFDataCreateMutable(nil, 0),
              let consumer = CGDataConsumer(data: mutableData),
              let context = CGContext(consumer: consumer, mediaBox: nil, nil)
        else { return }

        let entries = try await entries(from: repository.samplesFromTwoWeeks())
            .filter { entry in
                entry.value > 30
            }

        let pageSize = CGSize(width: 612, height: 792)

        ImageRenderer(content: PrintView(entries: entries)).render { size, render in
            let pageCount = Int(ceil(size.height / pageSize.height))
//            var mediaBox = CGRect(origin: .zero, size: )

            var offset = (size.height - pageSize.height) * -1.0

            for _ in 0..<pageCount {
                context.beginPage(mediaBox: nil)
                defer { context.endPDFPage() }
                
                context.translateBy(x: 0, y: offset)
                render(context)
                offset = offset + pageSize.height
                Swift.print(offset)
            }

            context.closePDF()
        }

        let pdfData = mutableData as Data
        printController.printingItem = pdfData

        printController.present(animated: true)
    }

    private static func entries(from samples: [GlucoseSample]) -> [PrintEntry] {
        samples.map(PrintEntry.init(_:))
    }
}
