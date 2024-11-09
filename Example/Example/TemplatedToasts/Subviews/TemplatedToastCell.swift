//
//  TemplatedToastCell.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit

final class TemplatedToastCell: UICollectionViewCell {
	static let reuseIdentifier: String = String(describing: TemplatedToastCell.self)
	
	override var isHighlighted: Bool {
		didSet {
			UIView.animate(withDuration: 0.15) {
				self.transform = self.isHighlighted ? .init(scaleX: 0.96, y: 0.96) : .identity
				self.alpha = self.isHighlighted ? 0.98 : 1
			}
		}
	}
	
	//MARK: - Subviews
	let titleLabel: UILabel = UILabel()
	let separatorView: UIView = UIView()
	
	//MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		updateSubviewsLayout()
	}
}

//MARK: - Configurator
extension TemplatedToastCell {
	func configure(title: String) {
		titleLabel.text = title
	}
}

//MARK: - Subviews layout
private extension TemplatedToastCell {
	var titleFrame: CGRect {
		CGRect(
			x: 16,
			y: 2,
			width: bounds.size.width - 32,
			height: bounds.size.height - 4
		)
	}
	
	var separatorFrame: CGRect {
		CGRect(
			x: 0,
			y: bounds.size.height - 2,
			width: bounds.size.width,
			height: 2
		)
	}
	
	func updateSubviewsLayout() {
		titleLabel.frame = titleFrame
		separatorView.frame = separatorFrame
	}
}

//MARK: - Base configuration
private extension TemplatedToastCell {
	func baseConfigure() {
		[separatorView, titleLabel]
			.forEach { addSubview($0) }
		
		backgroundColor = .systemBackground
		
		separatorView.backgroundColor = .separator
		
		titleLabel.textColor = .label
		titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
		titleLabel.textAlignment = .left
   }
}
