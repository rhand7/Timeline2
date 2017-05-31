//
//  MyTimer.swift
//  PowerNapTimer
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation

protocol TimerDelegate {            //1d. Create delegate protocol - delegate updates the UI
    func timerSecondTicked()
    func timerCompleted()
    func timerStopped()
}

class MyTimer {
    
    var timeRemaining: TimeInterval?
    var timer: Timer?
    
    var delegate: TimerDelegate?       //2d. include new delegate property to MyTimer
    
    var isOn: Bool {                                      //check if timer is running
        if timeRemaining != nil {
            return true
        } else {
            return false
        }
    }
    
    func asString() -> String {
        let timeRemaining = Int(self.timeRemaining ?? 5)  //nil coalesence - checking the self.timeRemaining and convert to Int so we can divide by minutes
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft*60)
        
        return String(format: "%02d:%02d", arguments: [minutesLeft, secondsLeft])
    }
    
    func startTimer(_ time: TimeInterval) {         //add -- (_ time: TimeInterval) to know how much time is remaining
        if !isOn {                                  //reads: if isOn = false
            timeRemaining = time
            DispatchQueue.main.async {           //
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    self.secondTicker()                //this closure checks the timer every second to see if still running
                })                                     //(_) could be replaced with (timer) and call fire or dismiss, etc.
            }
        }
    }
    
    func secondTicker() {                                       //updates label on screen w/ seconds
        guard let timeRemaining = timeRemaining else { return } //unwrap using guard let to see if it has a value
        if timeRemaining > 0 {                                  // timeRemaining exists b/c greater than 0
            self.timeRemaining = timeRemaining - 1              //subtract 1 second from timeRemaining
            delegate?.timerSecondTicked()                 //5d.
            print(timeRemaining)                                //print until <0 and go onto else
        } else {
            timer?.invalidate()       //if less than 0, we invalidate the timer and stop it
            self.timeRemaining = nil
            delegate?.timerCompleted()                   //6d.
        }
    }
    
    
    func stopTimer() {           //force stop w/ cancel
        if isOn {
            timeRemaining = nil  //set to nil
            delegate?.timerStopped()                    //7d.
        }
    }
    
}
