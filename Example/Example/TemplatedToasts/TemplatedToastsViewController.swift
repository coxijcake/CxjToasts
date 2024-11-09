//
//  TemplatedToastsViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit
import CxjToasts

final class TemplatedToastsViewController: UIViewController {
	//MARK: - Subviews
	@IBOutlet weak var collectionView: UICollectionView!
	
	private lazy var dataSource: TemplatedToastsListDiffableDataSource = TemplatedToastsListDiffableDataSource(
		collectionView: collectionView
	)
	
	private lazy var collectionLayout: UICollectionViewFlowLayout = {
		let layout: UICollectionViewFlowLayout = .init()
		layout.itemSize = .init(width: UIScreen.main.bounds.size.width, height: 60)
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		layout.scrollDirection = .vertical
		
		return layout
	}()
	
	//MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		baseConfigure()
		dataSource.reloadData()
	}
	
	//MARK: - IBActions
	@IBAction func closeButtonPressed() {
		dismiss(animated: true)
	}
}

extension TemplatedToastsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let toastType = dataSource.itemIdentifier(for: indexPath) else { return }
		
		switch toastType {
		case .native:
			CxjToastsCoordinator.shared.showToast(
				type: .templated(
					template: .native(
						data: CxjToastTemplate.NativeToastData(
							title: "Test Toast Toast Toast",
							subtitle: "some description",
							icon: .init(resource: .closeIcon),
							backgroundColor: .white
						)
					)
				)
			)
		case .bottomPrimary:
			CxjToastsCoordinator.shared.showToast(
				type: .templated(
					template: .bottomPrimary(
						data: CxjToastTemplate.BottomPrimaryToastData(
							customSourceView: nil,
							icon: .init(resource: .closeIcon),
							title: CxjToastTemplate.BottomPrimaryToastData.Title(
								text: "owofmqwofmqowf qowfm qowfmq owfmqow fqowf m",
								numberOfLines: 3,
								textColor: UIColor.black,
								font: .systemFont(ofSize: 21, weight: .bold)
							),
							subtitle: nil,
							background: .colorized(color: .white),
							shadowColor: .black.withAlphaComponent(0.5)
						)
					)
				)
			)
		}
	}
}

private extension TemplatedToastsViewController {
	func baseConfigure() {
		configureCollectionView()
	}
	
	func configureCollectionView() {
		collectionView.register(TemplatedToastCell.self, forCellWithReuseIdentifier: TemplatedToastCell.reuseIdentifier)
		collectionView.setCollectionViewLayout(collectionLayout, animated: false)
		collectionView.contentInset = .init(top: 100, left: .zero, bottom: 40, right: .zero)
		collectionView.delegate = self
	}
}
