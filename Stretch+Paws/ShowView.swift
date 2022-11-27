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
                        Text("How to")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
                        ForEach(pose.steps, id: \.self) { step in
                            Text(step)
                        }
                        Text("Tip")
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight"))
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
    @Binding var timerOpen: Bool
    var body: some View {
        VStack {
            Spacer()
            VStack {
                timerOpen ? AnyView(TimerOpenView()) : AnyView(TimerClosedView())
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
    var body: some View {
        VStack {
            Text("Hold that pose")
                .font(.system(size: 22))
            .fontWeight(.medium)
            Spacer()
            Text("Try staying in this pose until the timer finishes. If you need to come out for a moment, take a breath and make your way back into the pose. You've got this!")
                .multilineTextAlignment(.center)
            Spacer()
            Text("00:30")
                .font(.system(size: 96))
            Spacer()
            Button {
                //do something
            } label: {
                Text("Start timer")
            }.frame(width: 300, height: 50)
                .background(Color("Secondary"))
                .foregroundColor(Color("Primary"))
                .cornerRadius(30)
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
