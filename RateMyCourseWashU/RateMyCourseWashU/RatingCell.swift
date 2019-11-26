//
//  RatingCell.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/26/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class RatingCell: UICollectionViewCell {
    var username: UILabel? = nil
    var comment: UITextView? = nil
    var rating: CosmosView? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        username!.removeFromSuperview()
        comment!.removeFromSuperview()
        rating!.removeFromSuperview()
    }
}
