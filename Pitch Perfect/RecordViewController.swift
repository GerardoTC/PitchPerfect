//
//  RecordViewController.swift
//  Pitch Perfect
//
//  Created by Gerardo Tarazona Caceres on 2/1/20.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import AVFoundation
class RecordViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    var audioManager = AudioRecorderManager()
    var permissionGranted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtons(isRecording: false)
        audioManager.delegate = self
        setupNavBar()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        // Check permission to record.
        checkForAudioPermission()
    }
    
    @IBAction func startRecording(_ sender: Any) {
        guard permissionGranted else {
            showAlertError()
            return
        }
        updateButtons(isRecording: true)
        updateRecordingLabel(Constants.RecordingTexts.recording)
        audioManager.startRecording()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        updateButtons(isRecording: false)
        updateRecordingLabel(Constants.RecordingTexts.tapRecord)
        audioManager.stopRecording()
    }
    
    func updateRecordingLabel(_ message: String) {
        recordingLabel.text = message
    }
    
    func updateButtons(isRecording: Bool) {
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    
    func setupNavBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "AppIcon")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    func checkForAudioPermission() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self]granted in
            self?.permissionGranted = granted
        }
    }
    
    func showAlertError() {
        let alert = UIAlertController(title: Constants.Alerts.AudioPermissionErrorTitle,
                                      message:  Constants.Alerts.AudioPermissionErrorMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.Alerts.DismissAlert,
                                   style: .default) { [weak self] (alertAction) in
                                                        self?.dismiss(animated: true, completion: nil)
                                                    }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension RecordViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: Constants.Segues.stopRecording, sender: audioManager.audioRecorder?.url)
        } else {
            print("Record Audio failed ")
        }
        
    }
}

extension RecordViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.stopRecording,
            let playSoundsVC = segue.destination as? PlaySoundsViewController,
            let recordedAudioURL = sender as? URL {
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}
