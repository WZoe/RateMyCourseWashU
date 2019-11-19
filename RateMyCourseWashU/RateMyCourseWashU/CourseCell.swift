//
//  CourseCell.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class CourseCell: UICollectionViewCell {
    
    //todo: alter rect position and size
    
    var number:UILabel? = nil
    var title :UILabel? = nil
    var professor:UILabel? = nil
    var rating:UIProgressView? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        number!.removeFromSuperview()
        title!.removeFromSuperview()
        professor!.removeFromSuperview()
        rating!.removeFromSuperview()
    }
}
