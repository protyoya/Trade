

import SwiftUI

//header logo
struct HeaderLogoView: View {
    
    var body: some View {
        Text("_trade")
            .foregroundColor(.theme.accent)
            .font(.custom("Menlo",fixedSize: 24)) // TODO: change font
            .fontWeight(.bold)
    }
}

struct HeaderLogoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLogoView()
    }
}
