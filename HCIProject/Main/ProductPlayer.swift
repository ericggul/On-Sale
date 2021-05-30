import SwiftUI
import AVFoundation


struct ProductPlayer: View {
    @Binding var product: Product
    @Binding var volume: Float
    @State private var adjustable: Float = 0.5
    @State private var testBoolean: Bool = false
    @State private var speed = 4
    @State private var pitch = 4

    
    
    
    var body: some View {
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: 130, height: 4)
                .padding(5)

            
            HStack(spacing: 10){
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140)
                    .cornerRadius(5)
                    .padding()
                    .padding(.top)
                
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
            
                Button(action: {
                    speakUtterance()
                    product.nowPlaying = !product.nowPlaying
                    testBoolean = !testBoolean
                }, label:{
                    Image(systemName: testBoolean ? "play.fill":"play")
                        .font(.system(size: 100))
                        .foregroundColor(.primary)
                })


            List{
                Section(header: Text("음성 기본 빠르기/높이")){
                    HStack{
                        Stepper("음성 빠르기: \(speedCalculator(speed: speed))", value: $speed, in: 1...5)
                        Text("\(speed)/5")
                    }
                    HStack{
                        Stepper("음성 높이: \(pitchCalculator(pitch: pitch))", value: $pitch, in: 1...5)
                        Text("\(pitch)/5")
                    }
                }
                
                Section(header: Text("음성 변화/볼륨")){
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
        }.padding(5)
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
            
            speak(utterance)
        }
    }
    
    

    var synthesizer = AVSpeechSynthesizer()
    
    
    func speak(_ utterance: AVSpeechUtterance) {
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        self.synthesizer.speak(utterance)
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

struct ProductPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ProductPlayer(product: .constant(Product.initial[0]), volume: .constant(0))
    }
}
