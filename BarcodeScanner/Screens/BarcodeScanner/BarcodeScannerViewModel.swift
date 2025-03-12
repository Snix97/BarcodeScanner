//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 12/03/2025.
//

import SwiftUI

/*
 ObservableObject is a protocol that SwiftUI provides for objects that can be observed for changes.
 When you mark a class as conforming to ObservableObject, you’re signaling to SwiftUI that this object’s
 properties, when changed, should trigger a refresh of any views that depend on them. Any properties
 marked with @Published in an ObservableObject will automatically notify the view to update when they change.
 */

final class BarcodeScannerViewModel: ObservableObject {
    
    // The VM needs to "Publish/broadcast" its changes

    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    //Computed properties - Swift 5.1 if only 1 line you can omit the return statement
    var statusText: String {
       scannedCode.isEmpty ? "Not Yet scanned" : scannedCode
    }

    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
    
    
    
}
