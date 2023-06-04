import SwiftUI

struct IdentifiablePoint: Identifiable {
    let id = UUID()
    let point: CGPoint
}

struct GameView: View {
    @ObservedObject var motionManager: MotionManager
    @State private var x: CGFloat = 0
    @State private var y: CGFloat = 0
    @State private var obstacles: [IdentifiablePoint] = []
    @State private var gameOver = false
    let objectRadius: CGFloat = 25  // half the width and height of GameObject

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CameraView()
                    .edgesIgnoringSafeArea(.all)
                GameObject()
                    .position(x: geometry.size.width/2 + x * 500, y: geometry.size.height/2 + y * 500)
                    .animation(.spring())
                ForEach(obstacles) { obstacle in
                    Obstacle()
                        .position(obstacle.point)
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
            }
            .onDisappear {
                self.motionManager.stopUpdates()
            }
            .onChange(of: gameOver) { newValue in
                if newValue {
                    self.motionManager.stopUpdates()
                    // Handle game over, navigate back to start screen
                }
            }
        }
    }
}
