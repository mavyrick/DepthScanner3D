//
//  SceneViewModel.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import Foundation
import AVFoundation
import SceneKit
import Combine

class SceneViewModel: ObservableObject {
    
    @Published var geometry: SCNGeometry?
    
    var depthMapGeometryGenerator: DepthMapGeometryGeneratorProtocol
    
    var cancellables: Set<AnyCancellable> = []
    
    init(depthMapGeometryGenerator: DepthMapGeometryGeneratorProtocol) {
        self.depthMapGeometryGenerator = depthMapGeometryGenerator
    }
    
    func loadImage(image: UIImage) {
        
        // This is a hardcoded value that determines the degree of depth.
        // After some experimentation I found that an approriate value for this is 255.0.
        // However, this can change based on the requirements and depth image type.
        let maxDepth: CGFloat = 255.0
        
        depthMapGeometryGenerator.createDepthMapGeometry(from: image, maxDepth: maxDepth)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error generating depth map geometry: \(error.localizedDescription)")
                case .finished:
                    print("Depth map geometry created successfully")
                }
            } receiveValue: { [weak self] geometry in
                self?.geometry = geometry
            }
            .store(in: &cancellables)
    }
    
    
}
