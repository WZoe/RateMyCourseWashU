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
    
    let number:UILabel
    let title :UILabel
    let professor:UILabel
    let rating:UIProgressView
    
    override func prepareForReuse() {
        super.prepareForReuse()
        number.removeFromSuperview()
        title.removeFromSuperview()
        professor.removeFromSuperview()
        rating.removeFromSuperview()
    }
}
