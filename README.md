# BarcodeScanner
SwiftUI Barcode scanner app.  Passes data from UIKit to SwiftUI via a Coordinator and delegate because of the need to utilises the camera. Currently SwiftUI doesn't directly support UIKit elements like AVCaptureVideoPreviewLayer, so need to wrap UIKit views (like the camera preview) in a UIViewRepresentable struct to make them accessible within SwiftUI
