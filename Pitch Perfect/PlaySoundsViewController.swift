//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Gerardo Tarazona Caceres on 2/1/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var playerManager = AudioPlayerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerManager.setupAudio(url: recordedAudioURL,
                                 delegate: self)
        configureUI(.notPlaying)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPlaying()
    }
    
    @IBAction func playSoundFor(sender: UIButton) {
        switch sender {
        case slowButton:
            playerManager.playSound(rate:0.5)
        case fastButton:
            playerManager.playSound(rate:1.5)
        case highPitchButton:
            playerManager.playSound(pitch: 1000)
        case lowPitchButton:
            playerManager.playSound(pitch: -1000)
        case echoButton:
            playerManager.playSound(echo: true)
        case reverbButton:
            playerManager.playSound(reverb: true)
        default:
            print("Error Button for play sound not found")
        }
        configureUI(.playing)
    }
    
    @IBAction func stopPlaying() {
        playerManager.stopAudio()
        configureUI(.notPlaying)
    }
    
    
    func configureUI(_ playState: PlayingState) {
        switch(playState) {
        case .playing:
            setPlayButtonsEnabled(false)
            stopButton.isEnabled = true
        case .notPlaying:
            setPlayButtonsEnabled(true)
            stopButton.isEnabled = false
        }
    }
    
    func setPlayButtonsEnabled(_ enabled: Bool) {
        slowButton.isEnabled = enabled
        highPitchButton.isEnabled = enabled
        fastButton.isEnabled = enabled
        lowPitchButton.isEnabled = enabled
        echoButton.isEnabled = enabled
        reverbButton.isEnabled = enabled
    }

}

extension PlaySoundsViewController: AudioDidFinishDelegate {
    func audioFinished() {
        configureUI(.notPlaying)
    }
}

