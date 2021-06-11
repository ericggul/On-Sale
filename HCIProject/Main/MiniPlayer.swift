import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
            .combined(with: .opacity)
    }
}


struct MiniPlayer: View {
    var animation: Namespace.ID
    @Binding var expand: Bool
    @Binding var product: Product
    @State var volume: Float = 0
    @State var offset: CGFloat = 0
    
    @Binding var isActive: Bool
    
    var height = UIScreen.main.bounds.height/3
    
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 15){
                
                if expand{Spacer(minLength: 0)}
                
                if !expand{
                    Image(product.name)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .matchedGeometryEffect(id: "Picture", in: animation)
                }
                
                if !expand{
                    VStack(alignment: .leading){
                        Text("25분전")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .matchedGeometryEffect(id: "Time", in: animation)
                        Text("\(product.name)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animation)
                        Text("\(product.unitQuanity)\(product.unitMeasure.rawValue) \(product.discountPrice)원")
                            .matchedGeometryEffect(id: "Pricing", in: animation)
                    }
                }
                
                Spacer(minLength: 0)
                
                if !expand{
                    Button(action: {}, label:{
                        Image(systemName: "play.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                    })
                    .padding(5)
                }
                
            }.padding(.horizontal)
            
            if expand{
                MiniPlayerProduct(product: $product, fromMain: .constant(false),  isActive: $isActive)
            }
            
        }
        .frame(height: expand ? UIScreen.main.bounds.size.height : 100)
        .background(
            BlurView()
        )
        .offset(y: expand ? 0: UIScreen.main.bounds.size.height/2-100)
        .onTapGesture(perform: {
            withAnimation(.spring()){
                expand.toggle()
            }
        })
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
    }
    
    func onchanged(value: DragGesture.Value){
        if value.translation.height > 0 && expand{
            offset = value.translation.height
        }
        if value.translation.height > 0 && !expand {
            print("scrolled")
            offset =  250
        }
    }
    
    func onended(value: DragGesture.Value){
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            if value.translation.height > height{
                expand = false
            }
            offset = 0
        }
    }
}


