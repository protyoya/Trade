
import SwiftUI

struct ErrorView: View {
    var heading = NSLocalizedString("defaultErrorHeading", comment: "Error heading.") //for example error name - is translated
    var paragraph = NSLocalizedString("defaultErrorMessage", comment: "Error description.") //detailet error description, solution, ..., - is translated
    var showTryAgainButton = false
    var tryAgainAction: () async -> Void = { } //for example reload, when showTryAgainButton is true
    var showImage = true //if true show image of disconnected server and client
    var imageWidth: CGFloat = 272
    
    var body: some View {
        VStack(alignment: .center) {
            if showImage {
                Image("error")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
                    .padding(.bottom, 24)
            }
            
            Text(heading)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)
            
            Text(paragraph)
                .font(.subheadline)
                .foregroundColor(.theme.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
            
            if showTryAgainButton {
                tryAgainButton
            }
        }
    }
        
    private var tryAgainButton: some View {
        Button {
            Task {
                await tryAgainAction()
            }
        } label: {
            Image(systemName: "arrow.clockwise")
                .resizable()
                .scaledToFit()
                .frame(width: 28)
                .foregroundColor(.theme.accent)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(showTryAgainButton: true)
            .preferredColorScheme(.dark)
    }
}
