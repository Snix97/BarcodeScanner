//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 07/03/2025.
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

struct BarcodeScannerView: View {
    
    /*
     Ensure whenever scannedCode changes the view will get updated. Take info
     from coordinator and pass it to our scannerView. To do that we use @State
     variables and Bindings $
     */
    @State private var scannedCode = ""
    
    @State private var alertItem: AlertItem?
    
    //@State private var isShowingAlert = false - Used for Basic Alert example
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Add binding so whenever we change binding scannedCode in ScannerView we update the scannedCode @State variable here
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                
                //Just a spacer on its own pushes items to the top, but it can be customized with a frame
                Spacer().frame(height: 70)
                
                //Label element new in iOS 14. enables text and icon (SF Symbol or asset images)
                Label("Barcode Scanned:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not yet scanned" : scannedCode)
                    .bold()
                    .font(.title)
                    .foregroundColor(scannedCode.isEmpty ? .red :.green)
                    .padding()
                
                /*Temp example of button to trigger alert
                Button {
                    isShowingAlert = true
                } label: {
                    Text("Tap Me")
                }*/

            }
            .navigationTitle("Barcode Scanner")
            
            /*Temp example of Basic Alert
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text("Test"), message: Text("This is a test"), dismissButton: .default(Text("OK")))
            }) */
            
            /*
             Better more extensive way tpo do alerts - it waits to see which kind of alertItem it gets
             because you can't have more than 1 alert defined so pass in the require alertContext
             */
            .alert(item: $alertItem) { alertItem in
                Alert(title: Text(alertItem.title),
                          message: Text(alertItem.message),
                      dismissButton: alertItem.dismissbutton)
            }
        }
        //Make app look same on iPhone & iPad if omit it wont show full screen on iPad
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    BarcodeScannerView()
}
