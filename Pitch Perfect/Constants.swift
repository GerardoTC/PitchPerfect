//
//  Constants.swift
//  Pitch Perfect
//
//  Created by Gerardo Tarazona Caceres on 2/15/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: Alerts
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RecordingDisabledTitle = "Recording Disabled"
        static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
        static let RecordingFailedTitle = "Recording Failed"
        static let RecordingFailedMessage = "Something went wrong with your recording."
        static let AudioRecorderError = "Audio Recorder Error"
        static let AudioSessionError = "Audio Session Error"
        static let AudioRecordingError = "Audio Recording Error"
        static let AudioFileError = "Audio File Error"
        static let AudioEngineError = "Audio Engine Error"
        static let AudioPermissionErrorTitle = "Audio permission not granted"
        static let AudioPermissionErrorMessage = "please go to your settings and enable the capability to record"
    }
    
    struct RecordingTexts {
        static let tapRecord = "Tap to record"
        static let recording = "Recording in progress"
    }

    struct Segues {
        static let stopRecording = "stopRecordingSegue"
    }
}
