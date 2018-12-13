//
//  MotionViewController.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/5/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import UIKit
import CoreMotion

class MotionViewController: UIViewController {
    
    let motionManager = CMMotionManager()

    @IBOutlet weak var vectorX: UILabel!
    @IBOutlet weak var vectorY: UILabel!
    @IBOutlet weak var vectorZ: UILabel!
    
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(motionManager.isAccelerometerAvailable){
            motionManager.accelerometerUpdateInterval = 0.2
            
            motionManager.startAccelerometerUpdates()
            //motionManager.startAccelerometerUpdates(to:OperationQueue.current!,withHandler:updateAccelerometer)
            
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
        
    }
    
    func updateAccelerometer(accelData: CMAccelerometerData?, errorOC: Error?){
    
        var joke = accelData!.acceleration.x
        
        vectorX.text = String(format: "%06f", accelData!.acceleration.x)
        vectorY.text = String(format: "%06f", accelData!.acceleration.y)
        vectorZ.text = String(format: "%06f", accelData!.acceleration.z)
        
    }
    
    @objc func updateData(){
        
        vectorX.text = String(format: "%06f", motionManager.accelerometerData!.acceleration.x)
        vectorY.text = String(format: "%06f", motionManager.accelerometerData!.acceleration.y)
        vectorZ.text = String(format: "%06f", motionManager.accelerometerData!.acceleration.z)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
