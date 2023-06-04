// MotionManager.swift
import Foundation
import CoreMotion
import Combine

class MotionManager: ObservableObject {
    let motionManager = CMMotionManager()

    func startUpdates(handler: @escaping (Double, Double) -> Void) {
        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.accelerometerUpdateInterval = 0.1
            self.motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let validData = data {
                    handler(Double(validData.acceleration.x), Double(validData.acceleration.y))
                }
            }
        }
    }

    func stopUpdates() {
        self.motionManager.stopAccelerometerUpdates()
    }
}
