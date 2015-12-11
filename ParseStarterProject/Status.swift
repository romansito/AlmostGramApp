//
//  Status.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class Status {
	
	var image: UIImage
	var thumbnail: UIImage?
	var status: String
	
	init(image: UIImage, thumbnail: UIImage?, status: String) {
	self.image = image
	self.thumbnail = thumbnail
	self.status = status
	}
}
