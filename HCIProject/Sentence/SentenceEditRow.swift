//
//  SentenceRow.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI
import AVFoundation

struct SentenceEditRow: View {
    
    @Binding var script: Script
    @ObservedObject var vm = SpeachViewModel()
    
    var body: some View {
        HStack{
            Button(action: {
                vm.isSpeaking.toggle()
                if(vm.isSpeaking){
                    speakUtterance()
                }
                if(!vm.isSpeaking){
            
                }
            }){
                Image(systemName: vm.isSpeaking ? "play.fill": "play")
                    .foregroundColor(vm.isSpeaking ? .green : .gray)
                    .font(.title)
            }
//            TextField("Hello World", text: $script.sentence)
//                .foregroundColor(.primary)
//            Image(systemName: script.isSelected ? "checkmark.circle" : "circle")
//                .resizable()
//                .frame(width: 24, height: 24)
//
//                .onTapGesture {
//                    script.isSelected.toggle()
//                }
//                .padding(.trailing, 1)
            Toggle(isOn: $script.isSelected){
                TextField("Hello World", text: $script.sentence)
                    .foregroundColor(.primary)
            }
        }
    }
    
    func convertString(text: String) -> String{
        var newText = text.replacingOccurrences(of: "%", with: "프로")
        newText = newText.replacingOccurrences(of: "g", with: "그람")
        return newText
    }
    
    func speakUtterance(){
        let splittedTextArray = script.sentence.components(separatedBy: " ")
        
        let utterance = AVSpeechUtterance(string: convertString(text: script.sentence))
        utterance.rate = 0.5
        utterance.pitchMultiplier = 0.7
        utterance.volume = 1
        
        vm.speak(utterance)
    }
}



struct SentenceEditRow_Previews: PreviewProvider {
    static var previews: some View {
        SentenceEditRow(script: .constant(Script(sentence: "자, 여기 청주산 사과 하나 세일입니다", type: sentenceType.i, isSelected: true, isShown: true)))
    }
}

