import AVFoundation

@objc(CameraCaptureSession)
class CameraCaptureSession: NSObject {
  private var captureSession: AVCaptureSession?

  @objc func configureCaptureSession() {
    let captureSession = AVCaptureSession()
    guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
      print("Unable to access front camera")
      return
    }

    let videoInput: AVCaptureDeviceInput
    do {
      videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      print("Error setting up video input: \(error)")
      return
    }

    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      print("Unable to add video input to capture session")
      return
    }

    let videoOutput = AVCaptureVideoDataOutput()
    videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

    if captureSession.canAddOutput(videoOutput) {
      captureSession.addOutput(videoOutput)
    } else {
      print("Unable to add video output to capture session")
      return
    }

    self.captureSession = captureSession
    captureSession.startRunning()
  }

  @objc func stopCaptureSession() {
    captureSession?.stopRunning()
    captureSession = nil
  }

  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
