//
//  SceneView.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import Foundation
import SwiftUI
import UIKit

struct SceneView: UIViewControllerRepresentable {
    
    let depthImage: UIImage
        
    func makeUIViewController(context: Context) -> SceneViewController {
        let viewController = SceneViewController(depthImage: depthImage,
                                                 viewModel: SceneViewModel(
                                                    depthMapGeometryGenerator: DepthMapGeometryGenerator()
                                                 )
        )
        return viewController
    }

    func updateUIViewController(_ uiViewController: SceneViewController, context: Context) {
    }
}
