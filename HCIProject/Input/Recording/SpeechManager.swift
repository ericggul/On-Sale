//
//  SpeechManager.swift
//  STT Test
//
//  Created by Jeong Yoon Choi on 6/9/21.
//

import Foundation
import Speech

class SpeechManager{
    public var isRecording = false
    
    private var audioEngine: AVAudioEngine!
    private var inputNode : AVAudioInputNode!
    private var audioSession: AVAudioSession!
    
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    
    
    func start(completion: @escaping(String?) -> Void){
        if isRecording{
            stopRecording()
        } else{
            startRecording(completion: completion)
        }
    }
    
    func startRecording(completion: @escaping(String?) -> Void){
        guard let recognizer = speechRecognizer, recognizer.isAvailable else{
            print("Not available")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest();
        recognitionRequest!.shouldReportPartialResults = true
        
        recognizer.recognitionTask(with: recognitionRequest!){(result, error) in
            guard error == nil else {
                print("get error \(error!.localizedDescription)")
                return
            }
            guard let result = result else {return}
            
            if result.isFinal{
                completion(result.bestTranscription.formattedString)
            }
        }
        
        audioEngine = AVAudioEngine()
        
        inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){(buffer, _) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioEngine.start()
        } catch {
            print(error)
        }
        
    }
    
    func stopRecording(){
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        try? audioSession.setActive(false)
        audioSession = nil
    }
}

