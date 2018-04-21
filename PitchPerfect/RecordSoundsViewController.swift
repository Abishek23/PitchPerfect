//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Abishek Gokal on 25/02/2018.
//  Copyright © 2018 shektek. All rights reserved.
//

import UIKit
import AVFoundation

//MARK: - RecordSoundsViewController: UIViewController

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    //MARK: Properties
    var audioRecorder:AVAudioRecorder!
    
    @IBAction func recordAudio(_ sender: Any) {
    tapToRecordLabel.text = "Recording in progress"
    stopRecordingButton.isEnabled = true
    recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingnName = "recordedVoice.wav"
        let pathArray = [dirPath,recordingnName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecordingAudio(_ sender: Any) {
        print("Stop recording button pressed")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        tapToRecordLabel.text = "Tap To Record"
        audioRecorder.stop()
      
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        print("Stopped Recording")
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print( "Recording failed")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as? URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

