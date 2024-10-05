//
//  CxjIconedToastConfiguration.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit


public struct CxjIconedToastConfiguration {
    let params: IconParams
    
    public init(params: IconParams) {
        self.params = params
    }
}

extension CxjIconedToastConfiguration {
    public struct IconParams {
        public let icon: UIImage
        public let tintColor: UIColor?
		public let fixedSize: CGSize?
		
        public init(
            icon: UIImage,
            tintColor: UIColor? = nil,
			fixedSize: CGSize? = nil
        ) {
            self.icon = icon
            self.tintColor = tintColor
			self.fixedSize = fixedSize
        }
    }
}
