//
//  ImageCollectionViewCell.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	
	class func identifier() -> String {
		return "imageCell"
	}
}
