//
//  FilterService.swift
//  AlmostGram
//
//  Created by Roman Salazar Lopez on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import UIKit

class FilterService {
	
	private class func setupFilter(filterName: String, parameters : [String: AnyObject]?, image : UIImage) -> UIImage? {

		// Combert Image
		let image = CIImage(image : image)
		// Create Filter
		let filter : CIFilter
		
		// Check for Parameters
		
		if let parameters = parameters {
			filter = CIFilter(name: filterName, withInputParameters: parameters)!
		} else {
			filter = CIFilter(name: filterName)!
		}
	
		// Set image for KCIInput
		filter.setValue(image, forKey: kCIInputImageKey)
		
		//BoilerPlate Code
		//gpu context
		let options = [kCIContextWorkingColorSpace: NSNull()]
		let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
		let gpuContext = CIContext(EAGLContext: eaglContext, options: options)
		
		// Get final Image using GPU Rendering
		// After it applies spit out image at = the size to orinal
		let outputImage = filter.outputImage
		let extent = outputImage!.extent
		let cgImage = gpuContext.createCGImage(outputImage!, fromRect: extent)
		
		let finalImage = UIImage(CGImage: cgImage)
		
		return finalImage
		}

	// Input Image and send back image with Filter
	
	// Vintage Effect
	class func applyVintageEffect(image: UIImage, completion:(filteredImage: UIImage?, name: String) -> Void) {
		
		let filterName = VintageFilterKey
		let displayName = "Vntage"
		
		let finalImage = self.setupFilter(filterName, parameters: nil, image : image)
		NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
			completion(filteredImage: finalImage, name: displayName)
		}
	}
	// Black and White Filter
	
	class func applyBWEffect(image: UIImage, completion:(filteredImage: UIImage?, name: String) -> Void) {
		
		let filterName = BWFilterKey
		let displayName = "B&W"
		
		let finalImage = self.setupFilter(filterName, parameters: nil, image : image)
		NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
			completion(filteredImage: finalImage, name: displayName)
		}
	}

	// Chrome Filter
	
	class func applyChromeEffect(image: UIImage, completion:(filteredImage: UIImage?, name: String) -> Void) {
		
		let filterName = ChromeFilterKey
		let displayName = "Chrome"
		
		let finalImage = self.setupFilter(filterName, parameters: nil, image : image)
		NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
			completion(filteredImage: finalImage, name: displayName)
		}
	}

	
	
	
	
	
	
	
}
