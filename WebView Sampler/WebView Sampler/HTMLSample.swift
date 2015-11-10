//
//  HTMLSample.swift
//  WebView Sampler
//
//  Created by Hal Mueller on 11/8/15.
//  Copyright © 2015 Hal Mueller. All rights reserved.
//

struct HTMLSample {
    let description: String
    let URLString: String
    let isFile: Bool
    let filenameExtension: String?
	let dataString: String?
	
	init(description: String, URLString: String, isFile: Bool, filenameExtension: String?) {
		self.init(description: description, URLString: URLString, isFile: isFile, filenameExtension: filenameExtension, dataString: nil)
	}
	init(description: String, URLString: String, isFile: Bool, filenameExtension: String?, dataString: String?) {
		self.description = description
		self.URLString = URLString
		self.isFile = isFile
		self.filenameExtension = filenameExtension
		self.dataString = dataString
	}
}
