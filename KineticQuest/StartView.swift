// StartView.swift
import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Kinetic Quest")
                    .font(.largeTitle)
                    .padding()
                NavigationLink(destination: GameView(motionManager: MotionManager())) {
                    Text("Start")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}
