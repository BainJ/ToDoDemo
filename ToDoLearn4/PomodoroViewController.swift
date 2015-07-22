//
//  ViewController.swift
//  ClockLearn1
//
//  Created by bain on 15-4-27.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit
import AudioToolbox

class PomodoroViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var MinLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var restBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    var progress: KDCircularProgress!
    var startTime: NSDate?
    var endTime: NSDate?
    
    // 0：重置 1：工作 -1：休息
    var timeStatus: Int! {
        willSet(newStatus) {
            vibratePlay()
            progress.angle = 0
            progress.angle = 0
            if newStatus == 1 {
                remainingSeconds = timeManager.workTime
                setBtnStatusOff(startBtn)
                setBtnStatusOn(restBtn)
                
                startTime = NSDate()
                progress.setColors(workColor)
                progress.animateToAngle(360, duration: NSTimeInterval(timeManager.workTime), nil)
                soundPlay(0)
            }
            else if newStatus == -1 {
                remainingSeconds = timeManager.restTime
                setBtnStatusOff(restBtn)
                setBtnStatusOn(startBtn)
                endTime = NSDate()
                if startTime != nil {
                    if endTime != nil {
                        pomodoroHistoryManager.addNewData(startTime!, endTime: endTime!, duration: timeManager.workTime)
                    }
                }
                
                progress.setColors(restColor)
                
                endTime = nil
                startTime = nil
                
                progress.animateToAngle(360, duration: NSTimeInterval(timeManager.restTime), nil)
                soundPlay(1)
            }
            else if newStatus == 0 {
                remainingSeconds = timeManager.workTime
                
                setBtnStatusOn(startBtn)
                setBtnStatusOn(restBtn)
                
                endTime = nil
                startTime = nil
            }
        }
    }
    
    var remainingSeconds: Int = 0 {
        willSet(newSeconds) {
            let mins = newSeconds / 60
            let seconds = newSeconds % 60
            timeLabel!.text = NSString(format: "%02d", seconds)
            MinLabel!.text = NSString(format: "%02d", mins)
        }
    }
    
    
    var timer: NSTimer?
    
    let workColor = UIColor(red: 250/255.0, green: 121/255.0, blue: 160/255.0, alpha: 1.0)
    let restColor = UIColor(red: 84/255.0, green: 188/255.0, blue: 149/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        soundManager.initSound()
        progressInit()
        timeStatus = 0
        view.backgroundColor = UIColor(patternImage: UIImage(named: "mainBackground")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBtnStatusOn(button: UIButton) {
        
        if button == startBtn {
            button.setTitle("开始工作", forState: UIControlState.Normal)
        }
        if button == restBtn {
            button.setTitle("休息一下", forState: UIControlState.Normal)
        }
        button.enabled = true
        button.alpha = 1.0
        
    }
    
    func setBtnStatusOff(button: UIButton) {
        
        if button == startBtn {
            button.setTitle("工作中...", forState: UIControlState.Normal)
        }
        if button == restBtn {
            button.setTitle("休息中...", forState: UIControlState.Normal)
        }
        button.enabled = false
        button.alpha = 0.3
    }
    
    @IBAction func didStartBtnClick(sender: UIButton) {
        timeStatus = 1
        
        timer?.invalidate()
        timer = nil
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    @IBAction func didRestBtnClick(sender: UIButton) {
        timeStatus = -1
        
        timer?.invalidate()
        timer = nil
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer:", userInfo: nil, repeats: true)
    }
    
    @IBAction func didResetBtnClick(sender: UIButton) {
        timeStatus = 0
        soundPlay(2)
        timer?.invalidate()
        timer = nil
    }
    
    func soundPlay(tag: Int) {
        if (timeManager.soundStatus == true) {
            switch tag {
            case 0: soundManager.playerWork?.play()
            case 1: soundManager.playerRest?.play()
            case 2: soundManager.playerReset?.play()
            default : println("没有这种声音")
            }
        }
    }
    
    func vibratePlay() {
        if (timeManager.vibrateStatus == true) {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate));
        }
    }
    
    func progressInit() {
        progress = KDCircularProgress(frame: CGRect(x: (self.view.bounds.size.width - 400) / 2.0, y: 100, width: 400, height: 400))
        progress.startAngle = -90
        progress.progressThickness = 0.05
        progress.trackThickness = 0.1
        progress.trackColor = UIColor.whiteColor()
        //        progress.trackColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .Forward
        progress.glowAmount = 0.0
        progress.setColors(workColor)
        view.addSubview(progress)
    }
    
    func updateTimer(timer: NSTimer) {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
            if timeStatus == -1 {
                timeStatus = 1
            }
            else if timeStatus == 1 {
                timeStatus = -1
            }
        }
    }
    
    func refreshData(){
        timeManager = TimeManager()
        remainingSeconds = timeManager.workTime
        pomodoroHistoryManager.pomodoroInit()
        super.navigationController?.setNavigationBarHidden(true, animated: true)
        super.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
}


