//
//  DepthMapGeometryGenerator.swift
//  DepthScanner3D
//
//  Created by Josh Sorokin on 2023. 04. 24..
//

import Foundation
import SceneKit
import UIKit
import Combine

class DepthMapGeometryGenerator: DepthMapGeometryGeneratorProtocol {
    
    func createDepthMapGeometry(from image: UIImage, maxDepth: CGFloat) -> AnyPublisher<SCNGeometry, Error> {

        return Future<SCNGeometry, Error> { promise in
            DispatchQueue.global(qos: .userInteractive).async {
                
                guard let cgImage = image.cgImage else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get the CGImage from the UIImage"])))
                    return
                }
                
                let width = cgImage.width
                let height = cgImage.height
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                var rawData = [UInt8](repeating: 0, count: height * width * 4)
                let bytesPerPixel = 4
                let bytesPerRow = bytesPerPixel * width
                let bitsPerComponent = 8
                
                guard let context = CGContext(
                    data: &rawData,
                    width: width,
                    height: height,
                    bitsPerComponent: bitsPerComponent,
                    bytesPerRow: bytesPerRow,
                    space: colorSpace,
                    bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue // States that we don't need to worry about the alpha.
                ) else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create CGContext"])))
                    return
                }
                
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
                
                var vertices: [SCNVector3] = []
                for y in 0..<height {
                    for x in 0..<width {
                        let byteIndex = (bytesPerRow * y) + x * bytesPerPixel
                        let depth = CGFloat(rawData[byteIndex]) / 255.0
                        let position = SCNVector3(
                            x: Float(CGFloat(x) * CGFloat(width) / CGFloat(width - 1)),
                            y: Float(CGFloat(y) * CGFloat(height) / CGFloat(height - 1)),
                            z: Float(CGFloat(depth) * CGFloat(maxDepth))
                        )
                        vertices.append(position)
                    }
                }
                
                var indices: [UInt32] = []
                for y in 0..<height - 1 {
                    for x in 0..<width - 1 {
                        let i = y * width + x
                        // We need to append data for two triangles connected together, so 6 points.
                        indices.append(UInt32(i))
                        indices.append(UInt32(i + width))
                        indices.append(UInt32(i + 1))
                        indices.append(UInt32(i + 1))
                        indices.append(UInt32(i + width))
                        indices.append(UInt32(i + width + 1))
                    }
                }
                
                let source = SCNGeometrySource(vertices: vertices)
                let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
                let geometry = SCNGeometry(sources: [source], elements: [element])
                
                promise(.success(geometry))
            }
        }.eraseToAnyPublisher()
    }
    
}
