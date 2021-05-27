//
//  ProductPlayer.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 5/23/21.
//

import SwiftUI
import AVFoundation

struct ProductPlayer: View {
    @Binding var product: Product
    @Binding var volume: CGFloat
    @State private var adjustable: CGFloat = 0
    @ObservedObject var vm = SpeachViewModel()
    
    var body: some View {
        VStack{
            
            HStack(spacing: 10){
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140)
                    .cornerRadius(5)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10){
                    Text("25분전")
                        .foregroundColor(.secondary)

                    Text("\(product.name)")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("\(product.unitQuanity)\(product.unitMeasure.rawValue) \(product.discountPrice)원")

                    Text("\(product.origin)")
                }
            }
            
            //Sentence Section
                List{
                    Section(header: Text("선택된 문장들")){
                        ForEach(product.sentences){sentence in
                            SentenceRow(script: binding(for: sentence))
                        }
//                        .onMove(perform: move)
                    }
                }.listStyle(GroupedListStyle())
            
            HStack{
                Image(systemName: "speaker.fill")
                Slider(value: $volume)
                Image(systemName: "speaker.wave.2.fill")
            }
            .padding(2)
            
            HStack{
                Image(systemName: "speaker.fill")
                Slider(value: $volume)
                Image(systemName: "speaker.wave.2.fill")
            }
            .padding(2)
            
            HStack{
                Button(action: {
                    speakUtterance()
                }, label:{
                    Image(systemName: "play.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                })
                Button(action: {}, label:{
                    Image(systemName: "play.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.red)
                })
            }
            
            HStack{
                Image(systemName: "speaker.fill")
                Slider(value: $volume)
                Image(systemName: "speaker.wave.2.fill")
            }
            .padding(2)
           
            HStack{
                
            }
        }.padding(5)
    }
    
    var filteredScript: [Script]{product.sentences.filter{
        script in script.isSelected
    }
    }
    
//    func move(source: IndexSet, destination: Int){
//        product.sentences.move(fromOffsets: source, toOffset: destination)
//    }
    
    func aggregateSentence() -> String{
        var outputsen : String = ""
        for number in 0..<filteredScript.count{
            outputsen += filteredScript[number].sentence
            
        }
        return outputsen
    }
    
    func speakUtterance(){
        let utterance = AVSpeechUtterance(string: aggregateSentence())
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.7
        utterance.volume = 1
        
        vm.speak(utterance)
    }
    
    private func binding(for script: Script) -> Binding<Script> {
        guard let scriptIndex = product.sentences.firstIndex(where: { $0.id == script.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $product.sentences[scriptIndex]
    }
    
}

struct ProductPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ProductPlayer(product: .constant(Product.initial[0]), volume: .constant(0))
    }
}
