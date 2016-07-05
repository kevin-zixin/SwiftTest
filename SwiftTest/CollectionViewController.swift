//
//  CollectionViewController.swift
//  SwiftTest
//
//  Created by kevin on 7/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Photos
import MediaPlayer
import AVKit
class CollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    let identify:String = "collectioncell"
    var photoData = NSMutableArray()
    var albumName = NSMutableArray()
    var collectionList : UICollectionView!
    var videoPlayer = AVPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        
        configTop()
        self.view.backgroundColor = UIColor.whiteColor()
        let collectionListLayout = UICollectionViewFlowLayout()
        collectionListLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        collectionListLayout.itemSize = CGSizeMake(self.view.bounds.size.width/6, self.view.bounds.size.width/6)
        collectionListLayout.minimumLineSpacing = 10.0
        collectionListLayout.minimumInteritemSpacing = 0.0
        collectionListLayout.headerReferenceSize = CGSizeMake(20, 20)
        collectionListLayout.footerReferenceSize = CGSizeMake(20, 20)
        
        collectionList  = UICollectionView(frame: self.view.frame,collectionViewLayout: collectionListLayout)
        collectionList.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100)
        collectionList.translatesAutoresizingMaskIntoConstraints = false
        collectionList.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(collectionList)
        
        collectionList.dataSource = self
        collectionList.delegate = self
        collectionList.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: identify)
        fetchPhotos()
    }
    
    func configTop() {
        let appsArray:[String] = ["机载内置存储","机载外置存储","本地存储"]
        let segmentView = UISegmentedControl(items: appsArray)
        segmentView.frame = CGRectMake(0, 0, 300, 40)
        segmentView.center = CGPointMake(self.view.center.x, 60)
        segmentView.layer.cornerRadius = 20
        segmentView.layer.masksToBounds = true
        segmentView.layer.borderColor = UIColor.orangeColor().CGColor
        self.view.addSubview(segmentView)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identify, forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        let photoAsset = photoData[indexPath.row] as! PHAsset
        
        PHImageManager().requestImageForAsset(photoAsset, targetSize: CGSizeMake(100, 100), contentMode: PHImageContentMode.AspectFit, options: nil) { (photo, info) in
            cell.backgroundColor = UIColor.redColor()
            cell.photoView.image = photo
        }
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         let photoAsset = photoData[indexPath.row] as! PHAsset
        print(photoAsset.mediaType.rawValue)
        if photoAsset.mediaType.rawValue == 2 {

            PHImageManager().requestPlayerItemForVideo(photoAsset, options: nil, resultHandler: { (playerItem, info) in
                let value = info!["PHImageFileSandboxExtensionTokenKey"] as! NSString
                let result = value.componentsSeparatedByString(";") as NSArray
                let urlStr = result.lastObject
                let url = NSURL(fileURLWithPath: urlStr as! String)
                print(urlStr)
                dispatch_async(dispatch_get_main_queue(), {
                    self.videoPlayer.player = AVPlayer(URL: url)
                    self.navigationController?.presentViewController(self.videoPlayer, animated: true, completion: { 
                        //
                    })
                })
            })
            
        }
        
    }
    
    func fetchPhotos() {
        let albums : PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.AlbumRegular, options: nil)
        albums.enumerateObjectsUsingBlock { (album, index, ok) in
            if album.isKindOfClass(PHAssetCollection.self) {
                let photoAlbum = album as! PHAssetCollection
                print(photoAlbum.localizedTitle)
                self.albumName.addObject(photoAlbum.localizedTitle!)
                
                
                if photoAlbum.localizedTitle == "Test" {
                    let result : PHFetchResult = PHAsset.fetchAssetsInAssetCollection(album as! PHAssetCollection, options: nil)
                    result.enumerateObjectsUsingBlock({ (asset, indexNum, ifok) in
                        self.photoData.addObject(asset)
                        
                    })
                }
            }
        }

        if self.albumName.containsObject("Test") {
            
        }else{
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("Test")
                }, completionHandler: { (success, error) in
                    print("handler:\(success)")
            })
        }
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.collectionList.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
