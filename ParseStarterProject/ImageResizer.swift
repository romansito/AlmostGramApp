//
//  UIImageExtension.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
	
	class func ImageResizer(image: UIImage, size: CGSize) -> UIImage {
		
		UIGraphicsBeginImageContext(size)
		image.drawInRect(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
		// Grab Snapshot from the Context.
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		//End Image
		UIGraphicsEndImageContext()
		
		return resizedImage
	}
	
	
	
	
}