//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Claire Roughan on 07/03/2025.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 400)
                
                //Just a spacer on its own pushes items to the top, but it can be customized with a frame
                Spacer().frame(height: 70)
                
                //Label element new in iOS 14. enables text and icon (SF Symbol or asset images)
                Label("Barcode Scanned:", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text("Not yet scanned")
                    .bold()
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

#Preview {
    BarcodeScannerView()
}
