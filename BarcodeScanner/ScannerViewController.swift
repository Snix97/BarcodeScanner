//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 07/03/2025.
//

import Foundation
import AVFoundation
import UIKit

/*
 How SwiftUI communications with UIKit is through delegates and protocols.
 
 Coordinator is a relayer or translator in between SwiftUI and UIKit
 
 
 */

enum CameraError: String {
    case invalidDeviceInput = "Camera problems? - Unable to capture input"
    case invalidScannedValue = "The item scanned is not valid. This app scans EAN-6 and EAN-13 "
}

protocol ScannerViewControllerDelegate: AnyObject {
    
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    
    //previewLayer is what is picked up as you move the camera around its optional as it won't exist at first load
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate:(ScannerViewControllerDelegate)?
    
    init(scannerDelegate: ScannerViewControllerDelegate) {
        
        //Designated initialer for a UIViewController
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    //Needed if the ScannerViewController was initialised via a storyboard
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
  
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //As previewLayer is an optional show error - would be triggered if run on the simulator
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        //Setup the Preview layer after viewDidLayoutSubviews
        previewLayer.frame = view.layer.bounds
    }
    
    //Get camera looking for barcodes and preview layer up and running. With checks e.g camera access etc
    private func setupCaptureSession() {
        
        // Do we have a device to capture video?
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device:  videoCaptureDevice)
        } catch {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
            
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            //ean8, .ean13 are the dif type of barcode we can scan the number are the digits in the code
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        //Setup previewLayer to show the camera
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
    }
}

//What happens to the scsnned Barcode??
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
   func metadataOutput(_ ouput: AVCaptureMetadataOutput, didOutput metadataOnjects: [ AVMetadataObject], from connection: AVCaptureConnection) {
        
       guard let object = metadataOnjects.first else {
           scannerDelegate?.didSurface(error: .invalidScannedValue)
           return
       }
       
       guard let machineReadableOnject = object as? AVMetadataMachineReadableCodeObject else {
           scannerDelegate?.didSurface(error: .invalidScannedValue)
           return
       }
       
       guard let barcode = machineReadableOnject.stringValue else {
           scannerDelegate?.didSurface(error: .invalidScannedValue)
           return
       }
       
       /*S
        tops scanning as we have found a Barcode - but not used as you'd to include
        functionality e.g a button to restart the scanning process
        */
      // captureSession.stopRunning()
       scannerDelegate?.didFind(barcode: barcode)
    }
}










