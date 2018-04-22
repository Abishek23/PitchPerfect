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
    var isRecording:Bool!

    func configureUI(_ isRecording:Bool){
        if isRecording {
            tapToRecordLabel.text = "Recording in progress"
            recordButton.setImage(#imageLiteral(resourceName: "Stop"), for: .normal)
         
            
        } else {
            print("Stop recording button pressed")
       
            tapToRecordLabel.text = "Tap To Record"
            audioRecorder.stop()
            recordButton.setImage(#imageLiteral(resourceName: "Record"), for: .normal)
            
        }
    }
    
    func handleRecording(isRecording:Bool){
        if isRecording{
            configureUI(isRecording)
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let recordingnName = "recordedVoice.wav"
            let pathArray = [dirPath,recordingnName]
            guard let filePath = URL(string: pathArray.joined(separator: "/")) else {return}
            let session = AVAudioSession.sharedInstance()
            do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:.defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
            } catch {
                print(error.localizedDescription)
            }
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } else {
            configureUI(isRecording)
            let audioSession = AVAudioSession.sharedInstance()
            do {
            try audioSession.setActive(false)
            }catch {
                
                print(error.localizedDescription)
                
            }
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
       
    isRecording = !isRecording
    handleRecording(isRecording: isRecording)
      
   
    }
    
    
  
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        isRecording = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
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
            guard let recordedAudioURL = sender as? URL else {return }
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

