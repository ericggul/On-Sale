import SwiftUI


struct TextRecognition: View {
    @Binding var product: Product
    
    @State private var recognizedText = "Star to scan"
    @State private var showingScanningView = false
    
    var body: some View {
        VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray.opacity(0.2))
                        Text(recognizedText)
                            .padding()
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
//                    NavigationLink(destination: InputMain(product: $product)){
//                        Text("Next")
//                    }
                    
                    Button(action: {
                        self.showingScanningView = true
                    }) {
                        Text("Start Scanning")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                }
                .padding()
            }
            .navigationBarTitle("사진 찍기")
            .sheet(isPresented: $showingScanningView) {
                            ScanDocumentView(recognizedText: self.$recognizedText)
                        }
        }
}

struct TextRecognition_Previews: PreviewProvider {
    static var previews: some View {
        TextRecognition(product: .constant(Product.initial[0]))
    }
}
