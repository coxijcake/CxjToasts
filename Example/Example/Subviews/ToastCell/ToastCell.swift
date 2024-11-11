//
//  ToastCell.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit

protocol ToastCellDelegate: AnyObject {
	func showToastButtonPressedInCell(_ cell: ToastCell)
	func routeToPreviewButtonPressedInCell(_ cell: ToastCell)
}

final class ToastCell: UICollectionViewCell {
	static var reuseIdentifier: String { String(describing: ToastCell.self) }
	static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
	
	//MARK: - Subviews
	@IBOutlet weak var titleLabel: UILabel!
	
	//MARK: - Props
	override var isHighlighted: Bool {
		didSet {
			UIView.animate(withDuration: 0.15) {
				self.transform = self.isHighlighted ? .init(scaleX: 0.96, y: 0.96) : .identity
				self.alpha = self.isHighlighted ? 0.98 : 1
			}
		}
	}
	
	weak var delegate: ToastCellDelegate?
	
	//MARK: - Lifecycle
	override func awakeFromNib() {
		super.awakeFromNib()
		
		baseConfigure()
	}
	
	//MARK: - Overriden methods
	override func preferredLayoutAttributesFitting(
		_ layoutAttributes: UICollectionViewLayoutAttributes
	) -> UICollectionViewLayoutAttributes {
		let targetSize = CGSize(width: layoutAttributes.frame.width, height: .zero)
		
		layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(
			targetSize,
			withHorizontalFittingPriority: .required,
			verticalFittingPriority: .fittingSizeLevel
		)
		
		return layoutAttributes
	}
	
	//MARK: - IBActions
	@IBAction func showToastButtonPressed() {
		delegate?.showToastButtonPressedInCell(self)
	}
	
	@IBAction func routeToPreviewButtonPressed() {
		delegate?.routeToPreviewButtonPressedInCell(self)
	}
}

//MARK: - Configurator
extension ToastCell {
	func configure(title: String) {
		titleLabel.text = title
	}
}

//MARK: - Base configuration
private extension ToastCell {
	func baseConfigure() {
		
	}
}
