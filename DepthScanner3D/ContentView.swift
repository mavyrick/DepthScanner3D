//
//  ContentView.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ZStack {
            DepthCameraView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
