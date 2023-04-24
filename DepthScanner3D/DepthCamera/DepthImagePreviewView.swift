//
//  DepthImagePreviewView.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import SwiftUI

struct DepthImagePreviewView: UIViewControllerRepresentable {
        
    let depthImageUpdated: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> DepthImagePreviewViewController {
        let viewController = DepthImagePreviewViewController()
        viewController.depthImageUpdated = depthImageUpdated
        return viewController
    }

    func updateUIViewController(_ uiViewController: DepthImagePreviewViewController, context: Context) {
    }
}
