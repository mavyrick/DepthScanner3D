//
//  DepthCameraViewModel.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import Foundation
import UIKit

class DepthCameraViewModel: ObservableObject {
    
    @Published var depthImage: UIImage?
    
    func setDepthImage(image: UIImage) {
        depthImage = image
    }
    
}
