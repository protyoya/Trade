

import SwiftUI

struct SymbolsGridLoading: View {
    var body: some View {
        //centered loading
        HStack(alignment: .center) {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
        .padding(.top, 160)
    }
}

struct SymbolsGridLoading_Previews: PreviewProvider {
    static var previews: some View {
        SymbolsGridLoading()
    }
}
