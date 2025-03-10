
import SwiftUI

struct ContentView: View {
    @State private var navigationPath: [Symbol] = []
    
    var body: some View {
        NavigationView {
            NavigationStack(path: $navigationPath) {
                MarketsView(navigationPath: $navigationPath)
                    .foregroundColor(.theme.text)
            }
        }
        .onAppear {
            NotificationManager.shared.setUp()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
