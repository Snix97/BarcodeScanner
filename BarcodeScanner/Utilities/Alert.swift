//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 12/03/2025.
//

import SwiftUI

//The Identifiable protocol in SwiftUI allows you to add a unique object identity
struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissbutton: Alert.Button
}

//Helper to make it easy for call specific alerts
struct AlertContext {
    //Create our different alertItems
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input",
                                              message: "Camera problems? - Unable to capture input",
                                              dismissbutton: .default(Text("OK")))
    
    static let invalidScannedType = AlertItem(title: "Invalid Scanned Type",
                                              message: "The item scanned is not valid. This app scans EAN-6 and EAN-13 ",
                                              dismissbutton: .default(Text("OK")))
    
}
