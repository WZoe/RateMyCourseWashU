//
//  ProfCell.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/19/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class ProfCell: UICollectionViewCell {
    
    //todo: alter rect position and size
    
    var name:UILabel? = nil
    var department :UILabel? = nil
    var rating:CosmosView? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name!.removeFromSuperview()
        department!.removeFromSuperview()
        rating!.removeFromSuperview()
    }
}
