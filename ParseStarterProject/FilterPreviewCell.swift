//
//  FilterPreviewCell.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FilterPreviewCell: UICollectionViewCell {
	@IBOutlet weak var filtereImage: UIImageView!
	var image : UIImage? {
		didSet {
			if let image = image {
				self.filtereImage.image = image
			}
		}
	}
	
	class func identifier() -> String {
		return "FilteredCollectionViewCell"
	}
	
	
}
