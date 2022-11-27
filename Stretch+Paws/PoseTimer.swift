//
//  PoseTimer.swift
//  Stretch+Paws
//
//  Created by Jessica Perelman on 11/27/22.
//

import Foundation

// Where does it need to be shared?

class PoseTimer {
    var timerActive = false
    var timerPaused = false
    var timerEnded = false
    var timerDuration = 30
    var poseTimer = Timer()
    
    // Functionality:
    func startTimer() {
        timerActive = true
        poseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
                self.timerDuration -= 1
            if self.timerDuration == 0 {
                self.endTimer()
            }
            })
    }
    
    func pauseTimer() {
        timerActive = false
        timerPaused = true
        poseTimer.invalidate()
    }

    func endTimer() {
        // soundTimer
        poseTimer.invalidate()
        timerEnded = true
        timerActive = false
        timerDuration = 30
    }
    
    func soundTimer() {
        // play audio file
    }
}
