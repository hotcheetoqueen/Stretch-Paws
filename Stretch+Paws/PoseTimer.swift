//
//  PoseTimer.swift
//  Stretch+Paws
//
//  Created by Jessica Perelman on 11/27/22.
//

import Foundation
import AVFoundation

// Where does it need to be shared?

class PoseTimer: ObservableObject {
    @Published var timerActive = false
    @Published var timerPaused = false
    @Published var timerEnded = false
    @Published var timerDuration = 5
    var poseTimer = Timer()
    var audioPlayer: AVAudioPlayer?
    
    // Functionality:
    func startTimer() {
        timerActive = true
        timerPaused = false
        timerEnded = false
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
        soundTimer(sound: "chime", type: "wav")
        timerEnded = true
        timerActive = false
        poseTimer.invalidate()
        timerDuration = 30
    }
    
    func soundTimer(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Error")
            }
        }
    }
    
    func setPoseTitle() -> String{
        if timerEnded {
            return "You did it!"
        } else {
            return "Hold that pose"
        }
    }
    
    func setPoseDescription() -> String {
        if timerEnded {
            return "Purrrfect!"
        } else {
            return "Try staying in this pose until the timer finishes. If you need to come out for a moment, take a breath and make your way back into the pose. You've got this!"
        }
    }
}
