//
//  RecCell.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/26/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class RecCell: UICollectionViewCell {
    var title:UILabel? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title?.removeFromSuperview()
    }
    
}
