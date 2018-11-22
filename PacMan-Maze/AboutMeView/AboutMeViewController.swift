//
//  AboutMeViewController.swift
//  AleappAR
//
//  Created by Ferdinando Piedepalumbo on 10/11/2018.
//  Copyright © 2018 Ferdinando Piedepalumbo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class AboutMeViewController: UIViewController,ARSCNViewDelegate {
    
    @IBOutlet weak var scene2: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene2.delegate = self
        //scene2.showsStatistics = true
        
        let about = SCNScene (named: "art.scnassets/ship.scn")!
        
        scene2.scene = about
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
 super.viewWillAppear(animated)
 
 // Create a session configuration
 let configuration2 = ARImageTrackingConfiguration ()
 
        guard let arImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        configuration2.trackingImages = arImages
        
 // Run the view's session
 scene2.session.run(configuration2)
    
 }
 
 override func viewWillDisappear(_ animated: Bool) {
 super.viewWillDisappear(animated)
 
 // Pause the view's session
 scene2.session.pause()
 }
 
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARImageAnchor else { return }
        
        // Container
        guard let container = scene2.scene.rootNode.childNode(withName: "container", recursively: false ) else { return }
        container.removeFromParentNode()
        node.addChildNode(container)
        container.isHidden = false
        
        
        
    }
}

