//
//  ViewController.swift
//  SwiftTest
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 admin. All rights reserved.
//

import UIKit
import CoreMotion
import ContactsUI
class ViewController: UIViewController,CNContactPickerDelegate {
    
    var manager = CMMotionManager()
    var activityManager = CMMotionActivityManager()
    var pedometer = CMPedometer()
    var mylabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mylabel.frame = CGRectMake(100, 200, 200, 100)
        mylabel.textColor = UIColor.blueColor()
        mylabel.text = "0"
        self.view.addSubview(mylabel)
        // Do any additional setup after loading the view, typically from a nib.
        testStep()
        
        let testButton = UIButton()
        testButton.frame = CGRectMake(100, 400, 100, 40)
        testButton.backgroundColor = UIColor.redColor()
        testButton.addTarget(self, action: #selector(ViewController.testButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(testButton)
    }
    
    func testButtonClicked(){
        let pickerVC = CNContactPickerViewController()
        pickerVC.delegate = self
        pickerVC.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.presentViewController(pickerVC, animated: true) { 
            //
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func testStep()  {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = 9
        components.month = 5
        components.year = 2015
        components.hour = 24
        components.minute=0
        
        let startDate = calendar.dateFromComponents(components)
        let endDate = NSDate()
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.queryPedometerDataFromDate(startDate!, toDate: endDate, withHandler: { ( data :CMPedometerData?,error : NSError?) in
                print(data?.numberOfSteps)
                print(error)
            })
        }
        
        
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (data :CMPedometerData?,error : NSError?) in
                print(data?.numberOfSteps)
                self.mylabel.text = "\(data?.numberOfSteps)"
            })
        }
    }
    
    
    func testMotion () {
        
        
        
        manager.deviceMotionUpdateInterval = 1.0/10.0
        if manager.accelerometerAvailable {
            let queue = NSOperationQueue.currentQueue()
            manager.startAccelerometerUpdatesToQueue(queue!, withHandler: { ( accelerometerData : CMAccelerometerData?, error : NSError?) in
                if accelerometerData != nil {
                    
                    if accelerometerData?.acceleration.x>1.3{
                        print(accelerometerData?.acceleration.x)
                    }
                    
                    if accelerometerData?.acceleration.y>1.3{
                        print(accelerometerData?.acceleration.y)
                    }

                    if accelerometerData?.acceleration.z>1.3{
                        print(accelerometerData?.acceleration.z)
                    }


                }
            })
            
            manager.startDeviceMotionUpdatesToQueue(queue!, withHandler: { ( motion : CMDeviceMotion?, error : NSError?) in
                if motion != nil {
                    
                }
            })
            
            
            
            
            activityManager.startActivityUpdatesToQueue(queue!, withHandler: { (activity : CMMotionActivity?) in
                
                
                if (activity!.unknown) {
                   print("unknow")
                } else if (activity!.walking) {
                    print("walking")
                } else if (activity!.running) {
                    print("running")
                } else if (activity!.automotive) {
                    print("automotive")
                } else if (activity!.stationary) {
                    print("stationary")
                }
                

            })
            
            
        }
        
    }

    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        //
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        //
    }
    
    
}

