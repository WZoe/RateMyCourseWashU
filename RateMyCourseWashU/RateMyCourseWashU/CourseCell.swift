//
//  CourseCell.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class CourseCell: UICollectionViewCell {
    
    
    var number:UILabel? = nil
    var title :UILabel? = nil
    var professor:UILabel? = nil
//    var rating:UIProgressView? = nil
    var rating:CosmosView? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        number!.removeFromSuperview()
        title!.removeFromSuperview()
        professor!.removeFromSuperview()
        rating!.removeFromSuperview()
    }
}
