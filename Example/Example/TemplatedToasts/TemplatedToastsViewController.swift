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
		
		let template = TemplatedToastFactory.toastTemplateForType(
			toastType,
			customSourceView: nil
		)
		
		ToastPresenter.presentToastWithType(
			.templated(template: template),
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
