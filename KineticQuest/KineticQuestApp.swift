//
//  KineticQuestApp.swift
//  KineticQuest
//
//  Created by Wasif Kamruddin on 6/4/23.
//
// KineticQuestApp.swift
import SwiftUI
import AVFoundation

@main
struct KineticQuestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    var audioPlayer: AVAudioPlayer?

    init() {
        let sound = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Error: audio file not found")
        }
    }
}
