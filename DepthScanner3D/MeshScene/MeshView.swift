//
//  MeshView.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import SwiftUI

struct MeshView: View {
    
    let depthImage: UIImage
    
    var body: some View {
        ZStack {
            SceneView(depthImage: depthImage)
        }
    }
}
