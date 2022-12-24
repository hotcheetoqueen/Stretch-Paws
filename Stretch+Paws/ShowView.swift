//
//  ShowView.swift
//  Stretch+Paws
//
//  Created by Jessica Perelman on 11/26/22.
//

import SwiftUI

struct ShowView: View {
    let pose: Pose
    @State private var timerOpen = false
    var body: some View {
        ZStack {
            Color("Secondary")
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Image(pose.icon)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text(pose.name)
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(Color("Highlight"))
                    Text(pose.asana)
                        .font(.system(size: 22))
                        .italic()
                        .fontWeight(.medium)
                    VStack {
                        Text(pose.description)
                        Spacer()
                        Text("How to")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        Spacer()
                        ForEach(pose.steps, id: \.self) { step in
                            Text(step)
                        }
                        Text("Tip")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        Spacer()
                        Text(pose.topTip)
                    }
                }.padding(.horizontal, 24)
            }
            TimerPanelView(timerOpen: $timerOpen)
        }.onTapGesture {
            timerOpen = false
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView(pose: Pose(
            name: "Downward Dog",
            asana: "Adho Mukha Svana",
            icon: "Cat-1",
            description: "Did someone say dog? Can't we call this a downward-facing cat instead? It's OK – this is a friendly dog, it's not interested in chasing cats. In fact, Downward-Facing Dog is the lynchpin of a yoga asana practice: if you're going to befriend with any of these poses, make sure it's this canine classic.",
            steps: ["From a kneeling position, place your hands shoulder-distance apart and spread your fingers.", "Tuck your toes and lift your hips up towards the ceiling so you create an inverted V shape.", "Balance the weight between hands and feet and think about tilting your tailbone up towards the ceiling.","Send your gaze towards your feet and breath!"],
            topTip: "Bend your knees in order to create more length through the spine." 
        ))
    }
}

struct TimerPanelView: View {
    @StateObject var poseTimer = PoseTimer()
    
    @Binding var timerOpen: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                timerOpen ? AnyView(TimerOpenView(poseTimer: poseTimer)) : AnyView(TimerClosedView())
            }.frame(maxWidth: .infinity, maxHeight: timerOpen ? 400 : 80)
            .foregroundColor(Color("Secondary"))
            .background(Color("Highlight"))
            .cornerRadius(5)
        }.ignoresSafeArea()
            .onTapGesture {
                timerOpen.toggle()
            }
    }
}

struct TimerOpenView: View {
    @ObservedObject var poseTimer: PoseTimer

    var body: some View {
        VStack {
            Text(poseTimer.setPoseTitle())
                .font(.system(size: 22))
            .fontWeight(.medium)
            Spacer()
            Text(poseTimer.setPoseDescription())
                .multilineTextAlignment(.center)
            Spacer()
            if !poseTimer.timerEnded {
                CountdownView(poseTimer: poseTimer)
                Spacer()
            }
            if poseTimer.timerActive {
                TimerPauseButtonView(poseTimer: poseTimer)
            } else {
                TimerStartButtonView(poseTimer: poseTimer)
            }
        }.padding(30)
    }
}

struct TimerClosedView: View {
    var body: some View {
        Text("Try it out")
            .fontWeight(.medium)
            .padding(20)
        Spacer()
    }
}

struct CountdownView: View {
    @ObservedObject var poseTimer: PoseTimer
    var body: some View {
        Text(poseTimer.timerDuration < 10 ? "00:0\(poseTimer.timerDuration)" : "00:\(poseTimer.timerDuration)")
            .font(.system(size: 96))
    }
}

struct TimerPauseButtonView: View {
    @ObservedObject var poseTimer: PoseTimer
    var body: some View {
        Button {
            poseTimer.pauseTimer()
        } label: {
            Text("Pause timer")
                .padding(70)
        }.frame(width: 300, height: 50)
            .background(Color("Highlight"))
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(Color("Secondary"), lineWidth: 3)
            )
    }
}

struct TimerStartButtonView: View {
    @ObservedObject var poseTimer: PoseTimer
    var body: some View {
        Button {
            poseTimer.startTimer()
        } label: {
            Text(poseTimer.timerPaused || poseTimer.timerEnded ? "Restart timer" : "Start timer")
                .padding(70)
        }.frame(width: 300, height: 50)
            .background(Color("Secondary"))
            .foregroundColor(Color("Primary"))
            .cornerRadius(30)
    }
}
