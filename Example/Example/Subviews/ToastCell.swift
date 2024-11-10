//
//  ToastCell.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit

final class ToastCell: UICollectionViewCell {
	static let reuseIdentifier: String = String(describing: ToastCell.self)
	
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
}

//MARK: - Configurator
extension ToastCell {
	func configure(title: String) {
		titleLabel.text = title
	}
}

//MARK: - Subviews layout
private extension ToastCell {
	func setupConstraints() {
		[separatorView, titleLabel]
			.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
		
		NSLayoutConstraint.activate([
			separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
			separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
			separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 2),
			
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
		])
	}
}

//MARK: - Base configuration
private extension ToastCell {
	func baseConfigure() {
		setupSubviews()
		setupConstraints()
   }
	
	func setupSubviews() {
		[separatorView, titleLabel]
			.forEach { addSubview($0) }
		
		backgroundColor = .systemBackground
		
		separatorView.backgroundColor = .separator
		
		titleLabel.textColor = .label
		titleLabel.numberOfLines = 0
		titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
		titleLabel.textAlignment = .left
	}
}
