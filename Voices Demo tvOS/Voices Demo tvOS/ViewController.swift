//
//  ViewController.swift
//  Voices Demo tvOS
//
//  Created by Hal Mueller on 12/14/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let englishVoices = AVSpeechSynthesisVoice.speechVoices().filter({$0.language.hasPrefix("en")})
        print (englishVoices)

        let synth = AVSpeechSynthesizer()
        for voice in englishVoices {
            let utterance = AVSpeechUtterance(string: "hello world")
            utterance.voice = voice
            print (utterance.voice)
            synth.speakUtterance(utterance)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

