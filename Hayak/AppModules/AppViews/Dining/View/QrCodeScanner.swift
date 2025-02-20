//
//  QrCodeScanner.swift
//  Hayak
//
//  Created by wecancity on 05/09/2024.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerView
        var captureSession: AVCaptureSession?

        init(parent: QRCodeScannerView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                if let stringValue = readableObject.stringValue {
                    // Stop scanning after a successful read
                    captureSession?.stopRunning()

                    // Pass the scanned value to the parent view
                    parent.didFindCode(stringValue)
                }
            }
        }
    }
    
    var didFindCode: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
          let viewController = UIViewController()
          let captureSession = AVCaptureSession()
          context.coordinator.captureSession = captureSession

          guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
          let videoInput: AVCaptureDeviceInput

          do {
              videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
          } catch {
              return viewController
          }

          if captureSession.canAddInput(videoInput) {
              captureSession.addInput(videoInput)
          } else {
              return viewController
          }

          let metadataOutput = AVCaptureMetadataOutput()

          if captureSession.canAddOutput(metadataOutput) {
              captureSession.addOutput(metadataOutput)

              metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
              metadataOutput.metadataObjectTypes = [.qr]
          } else {
              return viewController
          }

          let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
          previewLayer.frame = viewController.view.layer.bounds
          previewLayer.videoGravity = .resizeAspectFill
          viewController.view.layer.addSublayer(previewLayer)

        // Run the capture session on a background thread to prevent UI blocking
             DispatchQueue.global(qos: .userInitiated).async {
                 captureSession.startRunning()
             }
        
          return viewController
      }

      func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
          
      }
    
  }
