//
//  ViewController.swift
//  ARKit Earth
//
//  Created by Ahsan Lakhani on 16/08/2018.
//  Copyright © 2018 Ahsan Lakhani. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode(geometry: SCNSphere(radius: 0.35))
        let moonParent = SCNNode()
        let venusParent = SCNNode()
        
        earth.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Earth day")
        earth.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        
        self.sceneView.scene.rootNode.addChildNode(earth)
        self.sceneView.scene.rootNode.addChildNode(moonParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.9,0,-0.3))
        
        
        
        let earthAction = Rotation(time: 10)
        let moonParentRotation = Rotation(time: 10)
        let venusParentRotation = Rotation(time: 10)
        let moonRotation = Rotation(time: 10)
        let venusRotation = Rotation(time: 10)
        
        
        moon.runAction(moonRotation)
        venus.runAction(venusRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonParentRotation)
        
        
        earth.runAction(earthAction)
        moonParent.addChildNode(moon)
        venusParent.addChildNode(venus)
        moonParent.addChildNode(moon)
        
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
        
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
