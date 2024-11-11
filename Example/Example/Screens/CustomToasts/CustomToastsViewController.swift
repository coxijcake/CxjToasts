//
//  CustomToastsViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 10/11/2024.
//

import UIKit
import CxjToasts

final class CustomToastsViewController: UIViewController {
	//MARK: - Subviews
	@IBOutlet weak var collectionView: UICollectionView!
	
	private lazy var dataSource: ToastsListDiffableDataSource = ToastsListDiffableDataSource(
		collectionView: collectionView,
		templateTypes: CustomToastType.allCases
	)
	
	private lazy var collectionLayout: UICollectionViewFlowLayout = {
		let layout: ToastListFlowLayout = ToastListFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 10
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

//MARK: - Main methods
private extension CustomToastsViewController {
	func presentToastType(atIndexPath indexPath: IndexPath) {
		guard let toastType: CustomToastType = dataSource.toastType(forIndexPath: indexPath) else { return }
		
		let toastData = CustomToastFactory.toastDataForType(
			toastType,
			customSourceView: view
		)
		
		ToastPresenter.presentToastWithType(
			.custom(data: toastData),
			strategy: .custom(
				strategy: .init(
					presentsCount: 1,
					delayBetweenToasts: 1.0
				)
			),
			animated: true
		)
	}
	
	func routeToPreviewToastType(atIndexPath indexPath: IndexPath) {
		guard let toastType: ToastType = dataSource.toastType(forIndexPath: indexPath) else { return }
		
		let previewVC: ToastPreviewViewController = ToastPreviewViewController.storyboardInstantiateInitialController()
		previewVC.input = .init(toastType: toastType)
		previewVC.modalPresentationStyle = .overFullScreen
		present(previewVC, animated: true)
	}
}

//MARK: - ToastCellDelegate
extension CustomToastsViewController: ToastCellDelegate {
	func showToastButtonPressedInCell(_ cell: ToastCell) {
		guard let indexPath: IndexPath = collectionView.indexPath(for: cell) else { return }
		
		presentToastType(atIndexPath: indexPath)
	}
	
	func routeToPreviewButtonPressedInCell(_ cell: ToastCell) {
		guard let indexPath: IndexPath = collectionView.indexPath(for: cell) else { return }
		
		routeToPreviewToastType(atIndexPath: indexPath)
	}
}

//MARK: - CollectionView Delegate
extension CustomToastsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let cell = cell as? ToastCell else { return }
		
		cell.delegate = self
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presentToastType(atIndexPath: indexPath)
	}
}

//MARK: - Base configuration
private extension CustomToastsViewController {
	func baseConfigure() {
		configureCollectionView()
	}
	
	func configureCollectionView() {
		collectionView.register(ToastCell.nib, forCellWithReuseIdentifier: ToastCell.reuseIdentifier)
		collectionView.setCollectionViewLayout(collectionLayout, animated: false)
		collectionView.contentInset = .init(top: 100, left: .zero, bottom: 40, right: .zero)
		collectionView.delegate = self
	}
}
