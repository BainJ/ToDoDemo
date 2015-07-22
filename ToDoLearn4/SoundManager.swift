//
//  SoundManager.swift
//  ClockLearn1
//
//  Created by bain on 15-4-29.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import AVFoundation

var soundManager: SoundManager = SoundManager()

class SoundManager: NSObject {
    
    var playerWork:AVAudioPlayer? = nil
    var playerRest:AVAudioPlayer? = nil
    var playerReset:AVAudioPlayer? = nil
    
    func loadSound(filename:NSString) -> AVAudioPlayer {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "wav")
        let player = AVAudioPlayer(contentsOfURL: url, error: nil)
        player.prepareToPlay()
        return player
    }
    
    func initSound() {
        playerWork = self.loadSound("work")
        playerRest = self.loadSound("rest")
        playerReset = self.loadSound("reset")
    }
}

//class ViewController: UIViewController {
//
//    var player_1:AVAudioPlayer? = nil
//    var player_2:AVAudioPlayer? = nil
//
//    func loadSound(filename:NSString) -> AVAudioPlayer {
//        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "aiff")
//        var error:NSError? = nil
//        let player = AVAudioPlayer(contentsOfURL: url, error: &error)
//        player.prepareToPlay()
//        return player
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.player_1 = self.loadSound("1")
//        self.player_2 = self.loadSound("2")
//    }
//
//    @IBAction func sound(sender: UIButton) {
//        self.player_1?.play()
//    }
//
//    @IBAction func sound2(sender: UIButton) {
//        self.player_2?.play()
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//}
