//
//  CustomToastsViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 10/11/2024.
//

import UIKit
import CxjToasts

//MARK: - Types
extension CustomToastsViewController {
	typealias ToastType = CustomToastType
}

final class CustomToastsViewController: UIViewController {
	//MARK: - Subviews
	@IBOutlet weak var collectionView: UICollectionView!
	
	private lazy var dataSource: ToastsListDiffableDataSource = ToastsListDiffableDataSource(
		collectionView: collectionView,
		templateTypes: ToastType.allCases
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

//MARK: - CollectionView Delegate
extension CustomToastsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let toastType: ToastType = dataSource.toastType(forIndexPath: indexPath) else { return }
		
		let toastdata = CustomToastFactory.toastDataForType(
			toastType,
			customSourceView: nil
		)
		
		ToastPresenter.presentToastWithType(
			.custom(data: toastdata),
			strategy: .custom(
				strategy: .init(
					presentsCount: 1,
					delayBetweenToasts: 1.0
				)
			),
			animated: true
		)
	}
}

//MARK: - Base configuration
private extension CustomToastsViewController {
	func baseConfigure() {
		configureCollectionView()
	}
	
	func configureCollectionView() {
		collectionView.register(ToastCell.self, forCellWithReuseIdentifier: ToastCell.reuseIdentifier)
		collectionView.setCollectionViewLayout(collectionLayout, animated: false)
		collectionView.contentInset = .init(top: 100, left: .zero, bottom: 40, right: .zero)
		collectionView.delegate = self
	}
}
