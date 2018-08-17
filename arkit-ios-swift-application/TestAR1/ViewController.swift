//
//  ViewController.swift
//  TestAR1
//
//  Created by Conbase1 on 03/08/18.
//  Copyright © 2018 Conbase1. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var planes : NSMutableDictionary = [:];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.delegate = self;
        self.planes = NSMutableDictionary();
        
        self.sceneView.showsStatistics = true;
        self.sceneView.autoenablesDefaultLighting = true;
        
        let scene = SCNScene();
        /*let box = SCNBox(width:0.1, height:0.1, length:0.1, chamferRadius:0.0);
        
        let node = SCNNode(geometry:box);
        node.position = SCNVector3Make(0.0, 0.0, -0.5);
        
        scene.rootNode.addChildNode(node);*/
        
        sceneView.debugOptions.insert(ARSCNDebugOptions.showWorldOrigin);
        sceneView.debugOptions.insert(ARSCNDebugOptions.showFeaturePoints);
        
        sceneView.scene = scene;
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal;
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if(!anchor.isKind(of: ARPlaneAnchor.self)) {
            return;
        }
        let arAnchor = anchor as! ARPlaneAnchor;
        print(arAnchor.extent.x, arAnchor.extent.z);
        let plane = Plane(anchor: anchor as! ARPlaneAnchor)
        self.planes.setObject(plane, forKey: anchor.identifier as NSCopying);
        node.addChildNode(plane);
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        let plane = self.planes.object(forKey: anchor.identifier) as! Plane;
        if(plane == nil) {
            return;
        }
        plane.update(anchor: anchor as! ARPlaneAnchor);
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        self.planes.removeObject(forKey: anchor.identifier)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
