//
//  DepthImagePreviewViewController.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import UIKit
import ARKit

class DepthImagePreviewViewController: UIViewController {
    
    private var depthImageView = UIImageView()
    private var session : ARSession?
    private var depthImage : UIImage?
    private var depthData : CVPixelBuffer?
    var depthImageUpdated: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        depthImageView.frame = view.bounds
        depthImageView.contentMode = .scaleAspectFit
        view.addSubview(depthImageView)
        
        session = ARSession()
        
        session?.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .sceneDepth
        configuration.isLightEstimationEnabled = true
        
        session?.run(configuration)
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Generate 3D Mesh", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func cgImage(from ciImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
    func rotate90DegreesCounterClockwise(_ ciImage: CIImage) -> CIImage {
        let transform = CGAffineTransform(rotationAngle: -.pi/2).translatedBy(x: -ciImage.extent.height, y: 0)
        return ciImage.transformed(by: transform)
    }
    
    @objc func buttonTapped() {
        if let depthImage = depthImage {
            depthImageUpdated?(UIImage())
        }
    }
}

extension DepthImagePreviewViewController: ARSessionDelegate{
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let depthData = frame.sceneDepth?.depthMap
        if let depthData = depthData {
            let ciImage = CIImage(cvPixelBuffer: depthData)
            let rotatedImage = rotate90DegreesCounterClockwise(ciImage)
            if let cgImage = cgImage(from: rotatedImage) {
                let depthImage = UIImage(cgImage: cgImage)
                depthImageView.image = depthImage
                self.depthImage = depthImage
                self.depthData = depthData
            }
        }
    }
    
}


