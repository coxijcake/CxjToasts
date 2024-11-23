//
//  ToastType.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import Foundation

protocol ToastType: Sendable {
	var id: String { get }
	var title: String { get }
}
