//
//  CxjMulticastPublisher.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import Foundation

final class CxjMulticastPublisher<T> {
	private let observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()

	func add(_ observer: T) {
		observers.add(observer as AnyObject)
	}
	
	func remove(_ observerToRemove: T) {
		for observer in observers.allObjects.reversed() {
			if observer === observerToRemove as AnyObject {
				observers.remove(observer)
			}
		}
	}
	
	func invoke(_ invocation: (T) -> Void) {
		for observer in observers.allObjects.reversed() {
			invocation(observer as! T)
		}
	}
}
