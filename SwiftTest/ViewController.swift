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
import CoreLocation
import CocoaAsyncSocket
import SystemConfiguration.CaptiveNetwork
import AVFoundation
import AVKit
class ViewController: UIViewController,CNContactPickerDelegate,CLLocationManagerDelegate,GCDAsyncUdpSocketDelegate {
    
    var manager = CMMotionManager()
    var activityManager = CMMotionActivityManager()
    var pedometer = CMPedometer()
    var mylabel = UILabel()
    var locationManager = CLLocationManager()
    var videoPlayer = AVPlayerViewController()
    var videoPlayer1 = KVVideoPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.hidden = true
        mylabel.frame = CGRectMake(100, 200, 200, 100)
        mylabel.textColor = UIColor.blueColor()
        mylabel.text = "0"
        self.view.addSubview(mylabel)
        // Do any additional setup after loading the view, typically from a nib.

        let testButton = UIButton()
        testButton.frame = CGRectMake(100, 400, 100, 40)
        testButton.backgroundColor = UIColor.redColor()
        testButton.addTarget(self, action: #selector(ViewController.testButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(testButton)
        
//        testLocation()
//        testMotion()
//        testUDP()
//        testSystemInfo()
        
//        let ssid = getSSID()
//        print(ssid)
//        setUpPlayer()
        
        let goCollectionButton = UIButton(frame: CGRectMake(100, 200, 100, 40))
        goCollectionButton.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(goCollectionButton)
        goCollectionButton .addTarget(self, action: #selector(ViewController.goCollectionView), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func goCollectionView() {
        let vc = CollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setUpPlayer() {
        videoPlayer.view.frame = CGRectMake(200, 200, 100, 100)
        self.view.addSubview(videoPlayer.view)
        let url = NSURL(string:"http://ishipin-sdk-web.dopool.com/abc_cb320b5052e48acb9afca0da4ea1933e65/live101/index_128k.m3u8")
        videoPlayer.player = AVPlayer(URL: url!)
        videoPlayer.player?.play()
        
        videoPlayer1.kvPlayer.view.frame = CGRectMake(400, 200, 100, 100)
        self.view.addSubview(videoPlayer1.kvPlayer.view)
        videoPlayer1.startPlaying("http://ishipin-sdk-web.dopool.com/abc_cb320b5052e48acb9afca0da4ea1933e65/live101/index_128k.m3u8")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    func getSSID() -> String? {
        let interfaces: CFArray! = CNCopySupportedInterfaces()
        if interfaces == nil { return nil }
        
        let if0: UnsafePointer<Void>? = CFArrayGetValueAtIndex(interfaces, 0)
        if if0 == nil { return nil }
        
        let interfaceName: CFStringRef = unsafeBitCast(if0!, CFStringRef.self)
        let dictionary = CNCopyCurrentNetworkInfo(interfaceName) as NSDictionary?
        if dictionary == nil { return nil }
        
        return dictionary?[kCNNetworkInfoKeySSID as String] as? String
    }

    
    func testButtonClicked(){
        let pickerVC = CNContactPickerViewController()
        pickerVC.delegate = self
        pickerVC.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.presentViewController(pickerVC, animated: true) { 
            //
        }
        
    }
    
    func testSystemInfo() {
        let batteryInfo = UIDevice.currentDevice().batteryLevel
        print("battery:\(batteryInfo)")
    }
    
    func testLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }else{
            print("not proved")
        }
    }
    
    func testUDP() {
        let  socket = GCDAsyncUdpSocket()
        socket.setDelegate(self)
        do {
            try socket.connectToHost("192.168.0.2", onPort: 8080)
        } catch {
            print("abc")
        }
    }
    
    func udpSocket(sock: GCDAsyncUdpSocket!, didConnectToAddress address: NSData!) {
       print("successed")
    }
    
    func udpSocket(sock: GCDAsyncUdpSocket!, didNotConnect error: NSError!) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let cuccentLocation : CLLocation = locations.last!
        print("longitude:\(cuccentLocation.coordinate.longitude)  latitude:\(cuccentLocation.coordinate.latitude) ")
        print("verticalAccuracy:\(cuccentLocation.verticalAccuracy)   horizontalAccuracy:\(cuccentLocation.horizontalAccuracy)")
        print("floor:\(cuccentLocation.floor)")
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
                    
                    if ((accelerometerData?.acceleration.x) != nil){
                        print(accelerometerData?.acceleration.x)
                    }
                    
                    if ((accelerometerData?.acceleration.y) != nil){
                        print(accelerometerData?.acceleration.y)
                    }

                    if ((accelerometerData?.acceleration.z) != nil){
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

