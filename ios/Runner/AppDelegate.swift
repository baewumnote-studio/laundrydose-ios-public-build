import Flutter
import UIKit
import Vision
import ImageIO

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var labelChannel: FlutterMethodChannel?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(name: "laundry_dose/label_scan",
      binaryMessenger: engineBridge.applicationRegistrar.messenger())
    labelChannel = channel
    channel.setMethodCallHandler { call, result in
      guard call.method == "readLabel" else { result(FlutterMethodNotImplemented); return }
      guard let args = call.arguments as? [String: Any], let path = args["path"] as? String,
            let support = FileManager.default.urls(for: .applicationSupportDirectory,
              in: .userDomainMask).first else {
        result(FlutterError(code: "invalid_photo", message: "Photo path missing", details: nil)); return
      }
      let file = URL(fileURLWithPath: path).resolvingSymlinksInPath().standardizedFileURL
      let photoRoot = support.appendingPathComponent("label_photos").resolvingSymlinksInPath().standardizedFileURL.path + "/"
      guard file.path.hasPrefix(photoRoot) else {
        result(FlutterError(code: "invalid_photo", message: "Photo is outside app storage", details: nil)); return
      }
      DispatchQueue.global(qos: .userInitiated).async {
        do {
          let request = VNRecognizeTextRequest()
          request.recognitionLevel = .accurate
          request.recognitionLanguages = ["en-US"]
          request.usesLanguageCorrection = false
          let handler = VNImageRequestHandler(url: file, options: [:])
          try handler.perform([request])
          let lines: [[String: Any]] = (request.results ?? []).compactMap { observation in
            guard let candidate = observation.topCandidates(1).first else { return nil }
            return ["text": candidate.string, "confidence": Double(candidate.confidence)]
          }
          DispatchQueue.main.async { result(lines) }
        } catch {
          DispatchQueue.main.async {
            result(FlutterError(code: "read_failed", message: "Unable to read label", details: nil))
          }
        }
      }
    }
  }
}
