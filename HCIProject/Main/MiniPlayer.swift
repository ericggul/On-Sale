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
    @State var volume: CGFloat = 0
    
    var height = UIScreen.main.bounds.height/3
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                
                if expand{Spacer(minLength: 0)}
                
                if !expand{
                    Image("p1")
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
                            .foregroundColor(.blue)
                    })
                    Button(action: {}, label:{
                        Image(systemName: "play.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    })
                }
                
            }.padding(.horizontal)
            
            if expand{
                ProductPlayer(product: $product, volume: $volume)
                //Main Info Section
//                HStack{
//                    Image("apple")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 140, height: 140)
//                        .cornerRadius(5)
//                        .matchedGeometryEffect(id: "Picture", in: animation)
//                        .padding(.horizontal)
//
//                    VStack(alignment: .leading, spacing: 10){
//                        Text("25분전")
//                            .foregroundColor(.secondary)
//                            .matchedGeometryEffect(id: "Time", in: animation)
//                        Text("\(product.name)")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .matchedGeometryEffect(id: "Label", in: animation)
//                        Text("\(product.unitQuanity)\(product.unitMeasure.rawValue) \(product.discountPrice)원")
//                            .matchedGeometryEffect(id: "Pricing", in: animation)
//                        Text("\(product.origin)")
//                    }
//                }
//
//                //Sentence Section
//
//                ForEach(product.sentences){sentence in
//                    SentenceRow(script: binding(for: sentence))
//                }
//
//                HStack{
//                    Button(action: {}, label:{
//                        Image(systemName: "play.fill")
//                            .font(.system(size: 100))
//                            .foregroundColor(.blue)
//                    })
//                    Button(action: {}, label:{
//                        Image(systemName: "play.fill")
//                            .font(.system(size: 100))
//                            .foregroundColor(.red)
//                    })
//                }
//
//                HStack{
//                    Image(systemName: "speaker.fill")
//                    Slider(value: $volume)
//                    Image(systemName: "speaker.wave.2.fill")
//                }
//                .padding()
//
//                HStack{
//
//                }
            }
            
        }
        .frame(height: expand ? UIScreen.main.bounds.height : 105)
        .background(
            BlurView()
        )
        .offset(y: expand ? 0: UIScreen.main.bounds.height/2-50)
        .ignoresSafeArea()
        .onTapGesture(perform: {
            withAnimation(.spring()){
                expand.toggle()
            }
        })
    }
}


