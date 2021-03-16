//
//  ViewController.swift
//  Pokemon3D
//
//  Created by Hanna Putiprawan on 3/15/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Add lighting to the scene
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration() // looking for a specific image that we provide
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            // Bundle.main = location of the current file
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 3
            print("Successfully find the card in the real world, and turn it into ARReferenceImage.")
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
//            print(imageAnchor.referenceImage.name)
            
            // Only if detect the image provided
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5) // make the plane on the card more transparent
            
            let planeNode = SCNNode(geometry: plane)
            
            // Rotate the planeNode by 90 degrees to make the plane flat down to the surface
            // - .pi/2 = anti-clockwise by half pi = 90 degrees
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            // Add 3d pokemon to the scene
            if imageAnchor.referenceImage.name == "eevee-card" {
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        planeNode.addChildNode(pokeNode)
                        pokeNode.eulerAngles.x = .pi/2 // rotate clockwise by 90 degrees
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "oddish-card" {
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        planeNode.addChildNode(pokeNode)
                        pokeNode.eulerAngles.x = .pi/2 // rotate clockwise by 90 degrees
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "pichu-card" {
                if let pokeScene = SCNScene(named: "art.scnassets/pichu.scn") {
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        planeNode.addChildNode(pokeNode)
                        pokeNode.eulerAngles.x = .pi/2 // rotate clockwise by 90 degrees
                    }
                }
            }
            
        }
        return node
    }
}
