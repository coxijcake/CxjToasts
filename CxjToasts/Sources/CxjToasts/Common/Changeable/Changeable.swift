import Foundation

protocol Changeable {
	associatedtype ChangeableCopy

	var changeableCopy: ChangeableCopy { get }

	init(copy: ChangeableCopy)
}

extension Changeable where ChangeableCopy == Self {
	var changeableCopy: ChangeableCopy { self }

	init(copy: ChangeableCopy) {
		self = copy
	}
}

extension Changeable {
	func changing(_ change: (inout ChangeableCopy) -> Void) -> Self {
		var copy = self.changeableCopy

		change(&copy)

		return Self(copy: copy)
	}
}
