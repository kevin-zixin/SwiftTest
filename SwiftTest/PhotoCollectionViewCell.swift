//
//  PhotoCollectionViewCell.swift
//  SwiftTest
//
//  Created by kevin on 7/5/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var photoView = UIImageView()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView.frame = CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.width-10)
        self.addSubview(photoView)
    }
    
}
