//
//  Model.swift
//  MagicCameraApp
//
//  Created by Aya Shikh Suliman on 13/12/2023.
//

import UIKit //create and manage the user interface
import RealityKit //provides tools and capabilities to create AR
import Combine //provides a declarative Swift API for processing values over time.

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                //handle error
                print("DEBUG: Unable to load model for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                //get modelentity
                self.modelEntity = modelEntity
                print("DEBUG: Successfully loaded model for modelName: \(self.modelName)")
                })
    }
}
