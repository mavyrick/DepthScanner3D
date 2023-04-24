//
//  DepthMapGeometryGeneratorProtocol.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 24..
//

import Foundation
import SceneKit
import UIKit
import Combine

protocol DepthMapGeometryGeneratorProtocol {
    func createDepthMapGeometry(from image: UIImage, maxDepth: CGFloat) -> AnyPublisher<SCNGeometry, Error>
}
