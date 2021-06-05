import SwiftUI
import AVFoundation

struct SoundPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var product: Product
    @State private var volume: Float = 1
    @State private var adjustable: Float = 0.5
    @State private var testBoolean: Bool = false
    @State private var speed = 4
    @State private var pitch = 4
    
    @Binding var shouldPopToRootView: Bool
    
    
    var body: some View {
        VStack{
            
            
            Button(action: {
                speakUtterance()
            }, label:{
                Image(systemName: testBoolean ? "play.fill":"play")
                    .font(.system(size: 100))
                    .foregroundColor(.primary)
            })
            .padding(10)
            
            Text(testBoolean ? "재생중": "음성 재생하기")
                .foregroundColor( testBoolean ? .green : .primary)
                .fontWeight(testBoolean ? .bold : .regular)
            

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
            
            Button(
                "완료",
                action: {
                    product.volume = volume
                    product.adjustable = adjustable
                    product.speed = speed
                    product.pitch = pitch
                    self.shouldPopToRootView = false
                }
            )
            .foregroundColor(.white)
            .font(.title2)
            .frame(width: UIScreen.main.bounds.width)
            .padding(.vertical)
            .padding(.horizontal)
            .background(Color(.black))
            .ignoresSafeArea()
        }
        .navigationTitle("음성 수정")
        .onAppear{
            volume = product.volume
            adjustable = product.adjustable
            speed = product.speed
            pitch = product.pitch
            
        }
    }
    
    let audioSession = AVAudioSession.sharedInstance()
    
    var filteredScript: [Script]{product.sentences.filter{
        script in script.isSelected
    }
    }

    
    func aggregateSentence() -> [String]{
        var outputsen : [String] = []
        for number in 0..<filteredScript.count{
            outputsen.append(filteredScript[number].sentence)
            
        }
        return outputsen
    }
    
    
    
    func speakUtterance(){
        testBoolean = !testBoolean
        let derivedSentences = aggregateSentence()
        for number in 0..<derivedSentences.count{
            let utterance = AVSpeechUtterance(string: derivedSentences[number])
            
            //default 0.5,
            utterance.rate = Float(Float.random(in: (0.5+(Float(speed)-3)*0.05-adjustable*0.2)..<(0.5+(Float(speed)-3)*0.05+adjustable*0.2)+0.01))
            //Pitch: 0.5-2, default 1
            utterance.pitchMultiplier = Float(Float.random(in: (1+(Float(pitch)-3)*0.1-adjustable*0.25)..<(1+(Float(pitch)-3)*0.1+adjustable*0.25)))
            //Volume: 0.1-1, default 1
            utterance.volume = Float(Float.random(in: (1-adjustable*0.1)*volume..<volume))
            utterance.postUtteranceDelay = 0.5
            speak(utterance, isPlaying: testBoolean)
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
        guard !testBoolean else { return }

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

struct SoundPage_Previews: PreviewProvider {
    static var previews: some View {
       SoundPage(product: .constant(Product.initial[0])
                 ,shouldPopToRootView: .constant(false))
    }
}

