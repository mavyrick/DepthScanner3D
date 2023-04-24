//
//  DepthCameraView.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import SwiftUI
import UIKit

struct DepthCameraView: View {
    
    @StateObject var viewModel = DepthCameraViewModel()
    
    @State private var navigate: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                DepthImagePreviewView() { image in
                    viewModel.setDepthImage(image: image)
                }
                if navigate, let depthImage = viewModel.depthImage {
                    // NavigationLink is recently deprecated but .navigationDestination was buggy
                    NavigationLink(destination: MeshView(depthImage: depthImage), isActive: $navigate) {
                        EmptyView()
                    }
                }
            }
            .onReceive(viewModel.$depthImage) { _ in
                navigate = true
            }
        }
    }
}
