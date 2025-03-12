//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 07/03/2025.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    /*
     Initialise a new VM so use @StateObject.
     If passing/injecting one down in a view hierachy use @ObservedObject
     */
    @StateObject var viewModel = BarcodeScannerViewModel()

    //@State private var isShowingAlert = false - Used for Basic Alert example
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Add binding so whenever we change binding scannedCode in ScannerView we update the scannedCode @State variable here
                ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                
                //Just a spacer on its own pushes items to the top, but it can be customized with a frame
                Spacer().frame(height: 70)
                
                //Label element new in iOS 14. enables text and icon (SF Symbol or asset images)
                Label("Barcode Scanned:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(viewModel.statusText)
                    .bold()
                    .font(.title)
                    .foregroundColor(viewModel.statusTextColor)
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
             Better more extensive way tpo do alerts - it waits to see which kind of
             alertItem it gets because you can't have more than 1 alert defined so pass
             in the require alertContext
             */
            .alert(item: $viewModel.alertItem) { alertItem in
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
