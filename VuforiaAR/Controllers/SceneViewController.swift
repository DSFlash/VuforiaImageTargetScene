//
//  SceneViewController.swift
//  ARBeacon
//
//  Created by InfyMac on 20/03/18.
//  Copyright © 2018 InfyMac. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation

class SceneViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var boxNode1 : SCNNode!
    var boxNode2 : SCNNode!
    var boxNode3 : SCNNode!
    var boxNode4 : SCNNode!
    var expandedBox : SCNBox!
    var locationManager : CLLocationManager!
    var isMonitoring : Bool = true
    var isInfy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))

        self.view.backgroundColor = UIColor(red: 73/256, green: 192/256, blue: 192/256, alpha: 1.0)

    }
    
    @objc func back() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //create configuration session
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1/2)) {
            self.addBox()
            self.addTap()
            self.addTapToRotate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //pause configuration session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ARKIT specific methods to add objects to the scene
    func addBox() -> Void {
        let image1 = isInfy ? "InfyBottom" : "Bottom"
        let image2 = isInfy ? "InfyRight" : "Right"
        let image3 = isInfy ? "InfyLeft" : "Left"
        let image4 = isInfy ? "InfyTop" : "Top"
        
        let box = SCNBox(width: 0.4, height: 0.4, length: 0.4, chamferRadius: 0.0)
        let imageToBox1 = SCNMaterial()
        let imageDisplay1 = UIImage(named: image1)
        imageToBox1.diffuse.contents = imageDisplay1
        box.materials = [imageToBox1]
        box.name = "Bottom"
        boxNode1 = SCNNode(geometry: box)
        boxNode1.position = SCNVector3(0,-0.8,-2)

        sceneView.pointOfView?.addChildNode(boxNode1)
        
        let box2 = SCNBox(width: 0.4, height: 0.4, length: 0.4, chamferRadius: 0.0)
        let imageToBox2 = SCNMaterial()
        let imageDisplay2 = UIImage(named: image2)
        imageToBox2.diffuse.contents = imageDisplay2
        box2.materials = [imageToBox2]
        box2.name = "Right"
        boxNode2 = SCNNode(geometry: box2)
        boxNode2.position = SCNVector3(1.0,0,-2)
        sceneView.pointOfView?.addChildNode(boxNode2)
        
        let box3 = SCNBox(width: 0.4, height: 0.4, length: 0.4, chamferRadius: 0.0)
        let imageToBox3 = SCNMaterial()
        let imageDisplay3 = UIImage(named: image3)
        imageToBox3.diffuse.contents = imageDisplay3
        box3.materials = [imageToBox3]
        box3.name = "Left"
        boxNode3 = SCNNode(geometry: box3)
        boxNode3.position = SCNVector3(-1.0,0,-2)
        sceneView.pointOfView?.addChildNode(boxNode3)
        
        let box4 = SCNBox(width: 0.4, height: 0.4, length: 0.4, chamferRadius: 0.0)
        let imageToBox4 = SCNMaterial()
        let imageDisplay4 = UIImage(named: image4)
        imageToBox4.diffuse.contents = imageDisplay4
        box4.materials = [imageToBox4]
        box4.name = "TopImage"
        
        boxNode4 = SCNNode(geometry: box4)
        boxNode4.position = SCNVector3(0.0,0.8,-2.0)
        boxNode4.name = "TopImage"
        sceneView.pointOfView?.addChildNode(boxNode4)
        
        //animate the nodes
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 3
        boxNode1.position = SCNVector3(0,-0.4,-2)
        boxNode2.position = SCNVector3(0.8,0,-2)
        boxNode3.position = SCNVector3(-0.8,0,-2)
        boxNode4.position = SCNVector3(0.0,0.3,-2.0)
        SCNTransaction.commit()
        
        //sceneView.autoenablesDefaultLighting = true
        //sceneView.allowsCameraControl = true
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    //startRangingBeacons()
                }
            }
        }
    }
    
    func removeExistingNodesOutOfRegion() -> Void {
        if boxNode4 != nil && boxNode3 != nil && boxNode2 != nil && boxNode1 != nil {
            boxNode1.removeFromParentNode()
            boxNode2.removeFromParentNode()
            boxNode3.removeFromParentNode()
            boxNode4.removeFromParentNode()
        }
    }
    //MARK: - Scene Tapped methods
    //scene tapped events
    func addTap() -> Void {
        
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(sceneTapped(sender:)))
        sceneView.addGestureRecognizer(gestureRec)
        
    }
    
    //scene tapped events to rotate
    func addTapToRotate() -> Void {
        
        let gestureToRotate = UIPanGestureRecognizer(target: self, action: #selector(sceneTappedToRotate(sender:)))
        sceneView.addGestureRecognizer(gestureToRotate)
        
    }
    
    @objc func sceneTappedToRotate(sender: UIPanGestureRecognizer) {
        let sceneView = sender.view as! SCNView
        let tapLoc = sender.location(in: sceneView)
        let hitResults = sceneView.hitTest(tapLoc, options: [:])
        if hitResults.count > 0 {
            let translation = sender.translation(in: sender.view!)
            
            let transx = Float(translation.x)
            let transy = Float(-translation.y)
            let anglePan = sqrt(pow(transx,2)+pow(transy,2))*(Float)(Double.pi)/180.0
            var rotVector = SCNVector4()
            
            rotVector.x = -transy
            rotVector.y = transx
            rotVector.z = 0
            rotVector.w = anglePan
            
            let tapped = hitResults[0]
            let tappedNode = tapped.node
            tappedNode.rotation = rotVector
        }
    }
    
    @objc func sceneTapped(sender:UIGestureRecognizer) {
        let sceneView = sender.view as! SCNView
        let tapLoc = sender.location(in: sceneView)
        let hitResults = sceneView.hitTest(tapLoc, options: [:])
        
        if hitResults.count > 0 {
            let tapped = hitResults[0]
            let tappedNode = tapped.node
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 2
            let derivedBox:SCNBox = tappedNode.geometry as! SCNBox
            derivedBox.height = 0.8
            derivedBox.width = 0.8
            derivedBox.length = 0.8
            
            //display the front of the node even if rotated while expanding or collapsing
            tappedNode.rotation = SCNVector4Make(0, 0, 0, 0)
            
            if tappedNode.name == "TopImage" {
                tappedNode.position.y = 0.2
            }
            else if tappedNode.name == "Bottom" {
                tappedNode.position.y = -0.2
            }
            
            //minimize the box
            if let exBox = expandedBox {
                exBox.height = 0.4
                exBox.width = 0.4
                exBox.length = 0.4
            }
            SCNTransaction.commit()
            
            if expandedBox == derivedBox {
                expandedBox = nil
            }
            else {
                expandedBox = derivedBox
            }
        }
    }
}
