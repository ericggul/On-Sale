import SwiftUI
import AVFoundation


struct MiniPlayerProduct: View {
    @Binding var product: Product
    @Binding var fromMain: Bool
    @State private var volume: Float = 1
    @State private var adjustable: Float = 0.5
    @State private var speed = 4
    @State private var pitch = 4
    
    //Detail View Presented?
    @State private var isPresented: Bool = false
    
    @Binding var isActive: Bool

    
    var body: some View {
        VStack{
            
            if !fromMain{
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 130, height: 4)
                    .padding(30)
                    .padding(.bottom, 10)
            }

            
            HStack(spacing: 10){
                
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(5)
                    .padding(3)
                
                Button(action: {
                    speakUtterance()
                 
                }, label:{
                    Image(systemName: product.nowPlaying ? "play.fill":"play")
                        .font(.system(size: 80))
                        .foregroundColor(.primary)
                })
                .padding(.trailing,20)
                
                
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
                    
                        ForEach(product.sentences){sentence in
                            SentenceRow(script: binding(for: sentence))
                        }
//                        .onMove(perform: move)
                
                }.listStyle(GroupedListStyle())
                .padding(0)
            

            List{
                Section(header: Text("문장 설정")){
                    HStack{
                        Text("음성 빠르기: \(speedCalculator(speed: speed))")
                        Spacer()
                        Text("\(speed)/5")
                    }
                    HStack{
                        Text("음성 높이: \(pitchCalculator(pitch: pitch))")
                        Spacer()
                        Text("\(pitch)/5")
                    }
                    HStack{
                        Text("변화 없음")
                        Image(systemName: "minus")
                        Slider(value: $adjustable)
                        Image(systemName: "plus")
                        Text("변화 많음")
                    }
                    HStack{
                        Text("볼륨 작음")
                        Image(systemName: "speaker.fill")
                        Slider(value: $volume)
                        Image(systemName: "speaker.wave.2.fill")
                        Text("볼륨 큼  ")
                    }
                }

            }.listStyle(GroupedListStyle())
//            .navigationBarItems(trailing: Button("Edit"){
//                isPresented = true
//            })
            .sheet(isPresented: $isPresented){
                NavigationView{
                    ProductPlayer(product: $product, fromMain: .constant(false), isActive: $isActive)
                }
            }
        }
    }
    
    var filteredScript: [Script]{product.sentences.filter{
        script in script.isSelected
    }
    }
    
//    func move(source: IndexSet, destination: Int){
//        product.sentences.move(fromOffsets: source, toOffset: destination)
//    }
    
    let audioSession = AVAudioSession.sharedInstance()
//    try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)

    
    func aggregateSentence() -> [String]{
        var outputsen : [String] = []
        for number in 0..<filteredScript.count{
            outputsen.append(filteredScript[number].sentence)
            
        }
        return outputsen
    }
    
    func speakUtterance(){
        
        product.nowPlaying = !product.nowPlaying
        let derivedSentences = aggregateSentence()
        for number in 0..<derivedSentences.count{
            let utterance = AVSpeechUtterance(string: derivedSentences[number])
            
            //default 0.5,
            utterance.rate = Float(Float.random(in: (0.5+(Float(speed)-3)*0.05-adjustable*0.2)..<(0.5+(Float(speed)-3)*0.05+adjustable*0.2)+0.01))
            //Pitch: 0.5-2, default 1
            utterance.pitchMultiplier = Float(Float.random(in: (1+(Float(speed)-3)*0.1-adjustable*0.25)..<(1+(Float(speed)-3)*0.1+adjustable*0.25)))
            //Volume: 0.1-1, default 1
            utterance.volume = Float(Float.random(in: (1-adjustable*0.1)..<1))
            utterance.postUtteranceDelay = 0.5
            
            speak(utterance, isPlaying: product.nowPlaying)
        }
    }
    
    

    var synthesizer = AVSpeechSynthesizer()
    
    
    func speak(_ utterance: AVSpeechUtterance, isPlaying: Bool) {
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        if(!isPlaying){
            if(synthesizer.isSpeaking){
                self.synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
                print("fired");
            }
        }
        else{
            if(synthesizer.isPaused){
                self.synthesizer.continueSpeaking();
            } else{
                self.synthesizer.speak(utterance)
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        guard !synthesizer.isSpeaking else { return }

        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false)
    }
    
    
    
    private func binding(for script: Script) -> Binding<Script> {
        guard let scriptIndex = product.sentences.firstIndex(where: { $0.id == script.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $product.sentences[scriptIndex]
    }
    
    private func speedCalculator(speed: Int) -> String{
        var value: String = ""
        
        if (self.speed==5) {value="매우 빠르게"}
        else if (self.speed==4) {value="빠르게"}
        else if (self.speed==3) {value="중간 빠르기"}
        else if (self.speed==2) {value="느리게"}
        else if (self.speed==1) {value="매우 느리게"}
        
        return value
    }
    
    private func pitchCalculator(pitch: Int) -> String{
        var value: String = ""
        
        if (self.pitch==5) {value="매우 높게"}
        else if (self.pitch==4) {value="높게"}
        else if (self.pitch==3) {value="중간 높이"}
        else if (self.pitch==2) {value="낮게"}
        else if (self.pitch==1) {value="매우 낮게"}
        
        return value
    }
    
}

struct MiniPlayerProduct_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MiniPlayerProduct(product: .constant(Product.initial[0]), fromMain: .constant(true),  isActive: .constant(false))
        }
    }
}

