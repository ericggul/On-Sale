
import SwiftUI

struct AlphaView: View {
    
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(
                destination: DetailView(rootIsActive: self.$isActive),
                isActive: self.$isActive)
                {Text("Push To Detail View.")}
                .isDetailLink(false)
            }
        }
    }
}

struct DetailView: View {
    @Binding var rootIsActive : Bool
    
    var body: some View {
        VStack {
            NavigationLink(destination: DetailView2(shouldPopToRootView: self.$rootIsActive))
            {Text("Push To DetailView2")}
            .isDetailLink(false)
        }
        
    }
}

struct DetailView2: View {
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        Button (action: { self.shouldPopToRootView = false } ){
                Text("Pop to root")
        }
    }
}


struct Alpha_Previews: PreviewProvider {
    static var previews: some View {
        AlphaView()
    }
}
