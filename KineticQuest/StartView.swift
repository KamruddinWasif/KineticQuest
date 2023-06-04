import SwiftUI
import UIKit

struct StartView: View {
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedImageView()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Text("Kinetic Quest")
                        .font(.custom("AvenirNext-Bold", size: 60))  // Replace with your desired font
                        .foregroundColor(.red)
                        .padding()

                    AnimatedTextView()

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
}

struct AnimatedImageView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        if let image = UIImage(named: "background.jpeg") {
            imageView.image = image
        }
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) { }
}

struct AnimatedTextView: View {
    @State private var animationPhase = 0

    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Are you ready to move?")
            .font(.title)
            .scaleEffect(self.animationPhase == 0 ? 1 : 1.1)
            .opacity(self.animationPhase == 0 ? 1 : 0.8)
            .onReceive(timer) { _ in
                self.animationPhase = self.animationPhase == 0 ? 1 : 0
            }
            .animation(.easeInOut(duration: 0.5))
    }
}
