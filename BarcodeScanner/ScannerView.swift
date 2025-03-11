//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 11/03/2025.
//

import SwiftUI

/*
 To present and dismiss a custom UIViewController on top of a SwiftUI view,
 you can create a UIViewRepresentable that will handle the presentation and
 dismissal of the view controller.  Your struct types need to conform to the
 UIViewRepresentable and UIViewControllerRepresentable protocols
 
 Build our coordinator in UIViewControllerRepresentable
 */
struct ScannerView: UIViewControllerRepresentable {
    
    //Create a Binding
    @Binding var scannedCode: String
    
    //Temp code to enable you to bring up the UIViewControllerRepresentable Protocol stubs
    //typealias UIViewControllerType = ScannerViewController
    
    //Body that SwiftUI returns is replaced with a ViewController
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate: context.coordinator)
    }
        
    //Just for protocol conformance - not used here
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    //When ScannerView gets called  makeCoordinator and makeUIViewController funcs get called automatically
    func makeCoordinator() -> Coordinator {
        
        //When we create our coordinator it needs a ScannerView
        Coordinator(scannerView: self)
    }
    
        
    /*
    Define class inside struct in case you need more coordinators in your app.
    If defined externally you'd have to name them specifically for each SwiftUI to
    UIKit usage senario. e.g cameraCoordinator, PageViewControllerCoordinator e.t.c
    Coordinator is the delegate of our ScannerViewController
    */
       
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        //UIKit tells the coordinator if found the barcode
        func didFind(barcode: String) {
            print(barcode)
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
    }
 
}

#Preview {
    ScannerView(scannedCode: .constant("12345678"))
}
