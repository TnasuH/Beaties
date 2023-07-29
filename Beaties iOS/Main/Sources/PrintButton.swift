import PhoneHealthConnect
import PhonePrinting
import SwiftUI

struct PrintButton: View {
    @Environment(\.healthRepository) private var repository

    var body: some View {
        Button {
            Task {
                do {
                    try await PrintService.print(repository: repository)
                } catch {
                    dump(error)
                }
            }
        } label: {
            Label(
                title: { Text("PrintButton.title") },
                icon: { Image(systemName: "printer") }
            )
        }
    }
}

#Preview {
    PrintButton()
}
