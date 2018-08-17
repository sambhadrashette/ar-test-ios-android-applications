//
//  Plane.swift
//  TestAR1
////  Created by Conbase1 on 17/08/18.
//  Copyright © 2018 Conbase1. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Plane: SCNNode {
    var planeGeomatry : SCNPlane?;
    var anchor : ARPlaneAnchor?;
    init(anchor : ARPlaneAnchor) {
        super.init();
        self.anchor = anchor;
        self.planeGeomatry = SCNPlane(width: CGFloat((self.anchor?.extent.x)!), height: CGFloat((self.anchor?.extent.z)! ));
        
        let material = SCNMaterial();
        let img = UIImage(named: "tron-albedo");
        material.diffuse.contents = img;
        
        self.planeGeomatry?.materials.append(material);
        
        let planeNode = SCNNode(geometry: self.planeGeomatry);
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi/2.0), 1.0, 0.0, 0.0);
        self.addChildNode(planeNode);
    }
    
    func update(anchor : ARPlaneAnchor) -> Void {
        self.planeGeomatry?.width = CGFloat(anchor.extent.x);
        self.planeGeomatry?.height = CGFloat(anchor.extent.z);
        
        self.position = SCNVector3Make(anchor.extent.x, 0.0,  anchor.extent.z)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
