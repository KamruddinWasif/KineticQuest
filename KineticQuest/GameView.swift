// GameView.swift
import SwiftUI

struct IdentifiablePoint: Identifiable {
    let id = UUID()
    var point: CGPoint
}

struct GameView: View {
    @ObservedObject var motionManager: MotionManager
    @State private var x: CGFloat = 0
    @State private var y: CGFloat = 0
    @State private var obstacles: [IdentifiablePoint] = []
    @State private var gameOver = false
    let objectRadius: CGFloat = 25  // half the width and height of GameObject
    let obstacleSpeed: CGFloat = 10  // You can adjust the speed as needed

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CameraView()
                    .edgesIgnoringSafeArea(.all)
                GameObject()
                    .position(x: geometry.size.width/2 + x * 500, y: geometry.size.height/2 + y * 500)
                ForEach(obstacles) { obstacle in
                    Obstacle()
                        .position(obstacle.point)
                }
                if gameOver {
                    Text("Game Over")
                        .font(.custom("AvenirNext-Bold", size: 50))  // Replace with your desired font
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                }
            }
            .onAppear {
                self.motionManager.startUpdates { x, y in
                    self.x = CGFloat(x)
                    self.y = CGFloat(y)
                    let gameObjectPosition = CGPoint(x: geometry.size.width/2 + CGFloat(x * 500), y: geometry.size.height/2 + CGFloat(y * 500))
                    for obstacle in self.obstacles {
                        if abs(obstacle.point.x - gameObjectPosition.x) < self.objectRadius && abs(obstacle.point.y - gameObjectPosition.y) < self.objectRadius {
                            self.gameOver = true
                        }
                    }
                }
                for _ in 1...5 {
                    let xPos = CGFloat.random(in: 0..<geometry.size.width)
                    let yPos = CGFloat.random(in: 0..<geometry.size.height)
                    obstacles.append(IdentifiablePoint(point: CGPoint(x: xPos, y: yPos)))
                }
                
                Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in  // Adjust the time interval as needed
                    for index in obstacles.indices {
                        if obstacles[index].point.y > geometry.size.height {
                            obstacles[index] = IdentifiablePoint(point: CGPoint(x: CGFloat.random(in: 0..<geometry.size.width), y: 0))  // Respawn at the top of the screen
                        } else {
                            let newY = obstacles[index].point.y + obstacleSpeed
                            obstacles[index] = IdentifiablePoint(point: CGPoint(x: obstacles[index].point.x, y: newY))
                        }
                    }
                }
            }
            .onDisappear {
                self.motionManager.stopUpdates()
            }
            .onChange(of: gameOver) { newValue in
                if newValue {
                    self.motionManager.stopUpdates()
                    // Here we just stop the updates and present the game over screen.
                    // You can modify this part to navigate back to the start screen or add more game over handling logic
                }
            }
        }
    }
}
