//
//  ToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 10/11/2024.
//

import UIKit
import CxjToasts

enum ToastFactory {
	enum Error: Swift.Error {
		case invalidToastType
	}
	
	static func cxjToastTypeFor(toastType: ToastType, customSourceView: UIView?) throws -> CxjToastType {
		if let customToastType = toastType as? CustomToastType {
			let toastData = CustomToastFactory.toastDataForType(customToastType, customSourceView: customSourceView)
			return .custom(data: toastData)
		} else if let templatedToastType = toastType as? TemplatedToastType {
			let templatedToastData = TemplatedToastFactory.toastTemplateForType(templatedToastType, customSourceView: customSourceView)
			return .templated(template: templatedToastData)
		} else {
			throw Error.invalidToastType
		}
	}
}
