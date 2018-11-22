//
//  ViewController.swift
//  AleappAR
//
//  Created by Ferdinando Piedepalumbo on 09/11/2018.
//  Copyright © 2018 Ferdinando Piedepalumbo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var node = SCNNode()  //Nodo per la creazione di oggetti
    var node2 = SCNNode() //Nodo per il mio albero
    var occhiali = SCNNode() //Nodo per i miei occhiali
    var pacman = SCNNode() //Nodo per pacman
   var albero = SCNNode()

    var new = SCNNode()
    
    var pallina1 = SCNNode()
    var pallina2 = SCNNode()
    var pallina3 = SCNNode()
    var pallina4 = SCNNode()
    var pallina5 = SCNNode()
    
    var nature = SCNNode()
    
    var video = SCNNode()
    
    let scene = SCNScene(named: "art.scnassets/Albero/albero.scn")!  //HO CREATO LA MIA SCENA CON L'ALBERO INCENTRATO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]  //PER VEDERE GLI ASSI
        self.sceneView.session.run(configuration) //PER VEDERE GLI ASSI
        
       
        
        // Set the view's delegate
        // sceneView.delegate = self
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        // Create a new scene
    
        
        
        
        node = (scene.rootNode.childNode(withName: "pc", recursively: true)!)
        addAnimation(node: node)
        
        
        node2 = (scene.rootNode.childNode(withName: "tree", recursively: true)!) //Aggiunta della rotazione al mio Albero
        addAnimation(node: node2)
        
        occhiali = (scene.rootNode.childNode(withName: "3d", recursively: true)!) //Aggiunta della rotazione al mio Albero
        addAnimation(node: occhiali)
        
        
        registerGestureRecognizers()
        
        
        
        // Set the scene to the view
        sceneView.scene = scene
       
        /*
        createNode(node: node)
        scene.rootNode.addChildNode(node) Creazione del mio "pacman" (Sfera gialla ma a nodo)
        */
        
        
        
    }
    /*
    @IBAction func upButton(_ sender: Any) {
        
        pacman = (scene.rootNode.childNode(withName: "Pac", recursively: true)!)
        albero = (scene.rootNode.childNode(withName: "tree", recursively: true)!)
        
        
        pallina1 = (scene.rootNode.childNode(withName: "1", recursively: true)!)
        pallina2 = (scene.rootNode.childNode(withName: "2", recursively: true)!)
        pallina3 = (scene.rootNode.childNode(withName: "3", recursively: true)!)
        pallina4 = (scene.rootNode.childNode(withName: "4", recursively: true)!)
        pallina5 = (scene.rootNode.childNode(withName: "5", recursively: true)!)
        
        let position = SCNVector3(-0.048,0.033,0.052) //Posizione vicino l'albero
        let move = SCNAction.move(to: position, duration: 2.5) //Muovere PacMan fino all'albero
        
        pacman.runAction(move)
        destroy(oggetto: pallina1)
        destroy(oggetto: pallina2)
        destroy(oggetto: pallina3)
        destroy(oggetto: pallina4)
        destroy(oggetto: pallina5)
        

    } */
    
    func destroy (oggetto : SCNNode){
        oggetto.removeFromParentNode()
    }
    
    
    /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
 
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    */
    
    
    func createNode( node: SCNNode){
        node.geometry = SCNBox.init(width: 0.03, height: 0.03, length: 0.03, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3 (0,0,0) //Posizione del mio nodo
        self.sceneView.scene.rootNode.addChildNode(node)
        addAnimation(node: node)
    }
    
    func addAnimation(node: SCNNode) {
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
    
    
    private func registerGestureRecognizers() {
    
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped2))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    @objc func tapped() { //recognizer :UIGestureRecognizer
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        
        let videoNode = SKVideoNode(fileNamed: "nature.mp4")
        videoNode.play()
        
        
        let skScene = SKScene(size: CGSize(width: 1000, height: 1000))
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x:skScene.size.width/2, y: skScene.size.height/2) //skScene.size.width/2, y: skScene.size.height)
        videoNode.size = skScene.size
        
        let tvPlane = SCNPlane(width: 0.320, height: 0.320)   //
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
       let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0
        
        tvPlaneNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        tvPlaneNode.eulerAngles = SCNVector3(Double.pi,0,0)
        
        self.sceneView.scene.rootNode.addChildNode(tvPlaneNode)
}
  
    @IBAction func natureButton(_ sender: Any) {
        tapped()
    }
    
    @IBAction func pcButton(_ sender: Any) {
        lol()
    }
    
    @IBAction func filmTrailerButton(_ sender: Any) {
        cine()
    }
    
    @objc func lol() { //recognizer :UIGestureRecognizer
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        
        let videoNode = SKVideoNode(fileNamed: "third.mp4")
        videoNode.play()
        
        let skScene = SKScene(size: CGSize(width: 100, height: 1000))
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x:skScene.size.width/2, y: skScene.size.height/2) //skScene.size.width/2, y: skScene.size.height)
        videoNode.size = skScene.size
        
        let tvPlane = SCNPlane(width: 0.320, height: 0.320)   //
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0
        
        tvPlaneNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        tvPlaneNode.eulerAngles = SCNVector3(Double.pi,0,0)
        
    
        self.sceneView.scene.rootNode.addChildNode(tvPlaneNode)
        
    }
    
    @objc func cine() { //recognizer :UIGestureRecognizer
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        
        let videoNode = SKVideoNode(fileNamed: "cinema.mp4")
        videoNode.play()
        
        let skScene = SKScene(size: CGSize(width: 1000, height: 1000))
        skScene.addChild(videoNode)
        
        videoNode.position = CGPoint(x:skScene.size.width/2, y: skScene.size.height/2) //skScene.size.width/2, y: skScene.size.height)
        videoNode.size = skScene.size
        
        let tvPlane = SCNPlane(width: 0.320, height: 0.320)   //
        tvPlane.firstMaterial?.diffuse.contents = skScene
        tvPlane.firstMaterial?.isDoubleSided = true
        
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0
        
        tvPlaneNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        tvPlaneNode.eulerAngles = SCNVector3(Double.pi,0,0)
        
        self.sceneView.scene.rootNode.addChildNode(tvPlaneNode)
        
        
    }
    
    @objc func tapped2(recognizer :UIGestureRecognizer) {
        
        guard let currentFrame = self.sceneView.session.currentFrame else {
            return
        }
        
        
        // create a web view
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 400, height:300))
        let request = URLRequest(url: URL(string: "https://www.youtube.com/watch?v=pjTj-_55WZ8")!)
        
        webView.loadRequest(request)
        
        let tvPlane = SCNPlane(width: 0.320, height: 0.320)
        tvPlane.firstMaterial?.diffuse.contents = webView
        tvPlane.firstMaterial?.isDoubleSided = true
        
        let tvPlaneNode = SCNNode(geometry: tvPlane)
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0
        
        tvPlaneNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        tvPlaneNode.eulerAngles = SCNVector3(0,0,0)
        
        self.sceneView.scene.rootNode.addChildNode(tvPlaneNode)
        
    }
    
}
