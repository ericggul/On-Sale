//
//  InputMain.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI

struct InputMainRecording: View {
    @Binding var product: Product
    @State private var datatoinherit: Product.Data = Product.Data()
    @State private var thisProduct: Product = Product.initial[0]
    @State private var updated = false
    @Binding var isActive: Bool
    
    @State private var results: [String] = []
    //Recordig Related
    @State private var recording = false

    @State private var thisText: String = ""
    
    
    @ObservedObject private var mic = MicMonitor(numberOfSamples: 30)
    
    @State private var speechManager = SpeechManager()
    
    var body: some View {
            VStack{
                InputTabs(productData: $datatoinherit)

                NavigationLink(destination:
                                SentenceList(product: $product
                                             , isActive: $isActive)
                                .onAppear{product.update(from: datatoinherit)}, isActive: $updated
                ){
                    NextButton(isLast:.constant(false))
                    .onTapGesture {
                        product.update(from: datatoinherit)
                        updated = true
                    }
                }
            }
            .navigationTitle("1. 품목 정보 수정")
            .onAppear{
                datatoinherit = product.hmmm
            }
        }
    
    func recordButton() -> some View {

            Image(systemName: recording ? "stop.fill" : "mic.fill")
                .font(.system(size: 40))
                .padding()
                .cornerRadius(10)
                .foregroundColor(.red)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            addItem()
                        })
                        .onEnded({ _ in
                            addItem()
                        })
                )
    }
    
    func normalizedSoundLevel(level: Float) -> CGFloat{
        let level = max(0.2, CGFloat(level) + 50)/2
        return CGFloat(level * (100 / 25))
    }
    
    
    func visualizerView() -> some View {
        VStack{
            VStack(spacing: 4){
                Text(thisText)
                HStack(spacing: 4){
                    ForEach(mic.soundSamples, id: \.self){level in
                        VisualBarView(value: self.normalizedSoundLevel(level: level))
                    }
                }
            }
        }
    }
    
    
    func addItem() {
        if speechManager.isRecording{
            self.recording = false
            mic.stopMonitoring()
            speechManager.stopRecording()
        } else{
            self.recording = true
            mic.startMonitoring()
            speechManager.start{ (speechText) in
                guard let text = speechText, !text.isEmpty else{
                    self.recording = false
                    return
                }
                
                DispatchQueue.main.async {
                    withAnimation{
                        results.append(text)
                    }
                }
            }
        }
        speechManager.isRecording.toggle()
    }
    
    

}



struct InputMainRecording_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            InputMainRecording(product: .constant(Product.initial[0]),isActive: .constant(false))
        }
    }
}

