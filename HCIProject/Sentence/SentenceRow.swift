//
//  SentenceRow.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI
import AVFoundation

struct SentenceRow: View {
    
    @Binding var script: Script
    @ObservedObject var vm = SpeachViewModel()

    @State private var playing = false
    
    var body: some View {
        HStack{
            Button(action: {
                vm.isSpeaking.toggle()
                speakUtterance()
                
            }){
                Image(systemName: vm.isSpeaking ? "play.fill": "play")
                    .foregroundColor(vm.isSpeaking ? .green : .gray)
                    .font(.title)
            }
            Text(script.sentence)
            Spacer()
            Text(script.isSelected ?
                "On" : "Off")
                .foregroundColor(script.isSelected ? .green : .gray)
                .bold()

        }
    }
    
    func convertString(text: String) -> String{
        var newText = text.replacingOccurrences(of: "%", with: "프로")
        newText = newText.replacingOccurrences(of: "g", with: "그람")
        return newText
    }
    
    func speakUtterance(){
        var splittedTextArray = script.sentence.components(separatedBy: " ")
        
        var utterance = AVSpeechUtterance(string: convertString(text: script.sentence))
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.7
        utterance.volume = 1
        
        vm.speak(utterance)
    }
}



struct SentenceRow_Previews: PreviewProvider {
    static var previews: some View {
        SentenceRow(script: .constant(Script(sentence: "자, 여기 청주산 사과 하나 세일입니다", type: sentenceType.i, isSelected: true)))
    }
}


