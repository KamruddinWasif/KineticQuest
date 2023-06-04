// CameraView.swift
import SwiftUI
import AVFoundation

struct CameraView: UIViewRepresentable {
    let session = AVCaptureSession()

    func makeUIView(context: Context) -> UIView {
        let previewView = UIView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
        
        guard let camera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: camera),
              session.canAddInput(input) else {
            print("Cannot access the camera.")
            return previewView
        }
        
        session.addInput(input)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                previewLayer.frame = previewView.bounds
            }
        }

        return previewView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            layer.frame = uiView.bounds
        }
    }
}
