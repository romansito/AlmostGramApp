//
//  API.swift
//  ParseStarterProject-Swift
//
//  Created by Roman Salazar Lopez on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import Parse

typealias ParseCompletionHandler = (sucess: Bool) -> ()

class API {
	
	class func uploadImage(image: UIImage, completion: ParseCompletionHandler) {
		
		if let imageData = UIImageJPEGRepresentation(image, 0.7) {
			
			let imageFile = PFFile(name: "image", data: imageData)
			let status = PFObject(className: "Status")
			status["image"] = imageFile
			
			status.saveInBackgroundWithBlock( { (sucess,error) -> Void in
				if sucess {
					completion(sucess: sucess)
				} else {
					completion(sucess: false)
				}
			})
		}
	}
}
