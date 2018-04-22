//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Abishek Gokal on 21/04/2018.
//  Copyright © 2018 shektek. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    var recordedAudioURL:URL!
    @IBOutlet weak var selectFilterLabel: UILabel!
    @IBOutlet weak var snailButton:UIButton!
    @IBOutlet weak var chipmunkButton:UIButton!
    @IBOutlet weak var rabbitButton:UIButton!
    @IBOutlet weak var vaderButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var stopButton:UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    var buttons:[UIButton]!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    @IBAction func playSoundForButton(_ sender:UIButton) {
        print("play Sound Button Pressed")
        
        guard let buttonType = ButtonType(rawValue: sender.tag) else {return}
        switch buttonType {
        case.slow:
            durationLabel.text = "Duration:\(playSound(rate:0.5))"
            setButtonsState()
        case .fast:
            durationLabel.text = "Duration:\(playSound(rate:1.5))"
            setButtonsState()
        case.chipmunk:
            durationLabel.text = "Duration:\(playSound( pitch: 1000))"
            setButtonsState()
        case .vader:
            durationLabel.text = "Duration:\(playSound(pitch:-1000))"
            setButtonsState()
        case .echo:
            durationLabel.text = "Duraiton:\(playSound(echo:true))"
            setButtonsState()
        case .reverb:
          durationLabel.text = "Duration\(playSound(reverb:true))"
            setButtonsState()
   
        }
    }
    
    func setButtonsState(){
        for button in buttons {
            button.isEnabled = !button.isEnabled
        
        }
        
    }
    
    @IBAction func stopButtonPressed(_ sender:UIButton) {
        print("Stop Button Pressed")
        stopAudio()
        setButtonsState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        buttons = [snailButton,chipmunkButton,rabbitButton,vaderButton,echoButton,reverbButton,stopButton]
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopAudio()
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
