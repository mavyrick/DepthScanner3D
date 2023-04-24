//
//  SceneViewController.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 16..
//

import UIKit
import SceneKit
import Combine

class SceneViewController: UIViewController {
    
    var viewModel: SceneViewModel
    
    let sceneView = SCNView(frame: UIScreen.main.bounds)
    
    var depthImage: UIImage
        
    init(depthImage: UIImage, viewModel: SceneViewModel) {
        self.depthImage = depthImage
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadImage(image: depthImage)
        observeGeometry()
    }
    
    func observeGeometry() {
        viewModel.$geometry
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] geometry in
                self?.setUpSceneView(geometry: geometry)
            }
            .store(in: &viewModel.cancellables)
    }
    
    func setUpSceneView(geometry: SCNGeometry) {
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.lightGray
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.gray // mesh color
        geometry.materials = [material]
        
        let depthMeshNode = SCNNode(geometry: geometry)
        depthMeshNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: .pi)
        depthMeshNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: .pi)
        scene.rootNode.addChildNode(depthMeshNode)
        
        scene.rootNode.position.z -= 250
        
        view.addSubview(sceneView)
    }
    
}
