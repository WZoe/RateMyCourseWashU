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
    
    let number = UILabel(frame: CGRect(x: 0, y: 140, width: 120, height: 40))
    let title = UILabel(frame: CGRect(x: 0, y: 140, width: 120, height: 40))
    let professor = UILabel(frame: CGRect(x: 0, y: 140, width: 120, height: 40))
    let rating = UILabel(frame: CGRect(x: 0, y: 140, width: 120, height: 40))
    
    override func prepareForReuse() {
        super.prepareForReuse()
        number.removeFromSuperview()
        title.removeFromSuperview()
        professor.removeFromSuperview()
        rating.removeFromSuperview()
    }
}
