
import SwiftUI

struct VisualBarView: View {
    var value: CGFloat
    let numberOfSamples: Int = 30
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 5) / CGFloat(numberOfSamples), height: value)
        }
    }
}

struct VisualBarView_Previews: PreviewProvider {
    static var previews: some View {
        VisualBarView(value: 0.5)
    }
}

