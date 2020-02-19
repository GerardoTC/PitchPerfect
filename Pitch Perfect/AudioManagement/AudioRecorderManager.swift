//
//  AudioRecorderManager.swift
//  Pitch Perfect
//
//  Created by Gerardo Tarazona Caceres on 2/15/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import AVFoundation

class AudioRecorderManager {
    var audioRecorder: AVAudioRecorder?
    var delegate: AVAudioRecorderDelegate?
    
    func setupSession() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord,
                                    mode: AVAudioSession.Mode.default,
                                    options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        } catch (let error) {
            print("Error trying set category for audio session \(error)")
            return
        }
    }
    
    func createFilePath() -> URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        return filePath
    }
    
    func startRecording() {
        guard let filePath = createFilePath() else {
            return
        }
        setupSession()
        do {
            try audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
            audioRecorder?.delegate = delegate
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
        } catch (let error) {
            print("Error trying to instatiate Audio recorder: \(error)")
            return
        }
    }
    
    
    func stopRecording() {
        audioRecorder?.stop()
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch (let error) {
            print("Error changing status Audio session \(error)")
        }
    }
}
