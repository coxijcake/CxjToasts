//
//  ToastsListDiffableDataSource.swift
//  Example
//
//  Created by Nikita Begletskiy on 06/11/2024.
//

import UIKit

extension ToastsListDiffableDataSource {
	typealias DiffableDataSource = UICollectionViewDiffableDataSource<SectionIdentifier, CellItem>
	typealias DiffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, CellItem>
	
	enum SectionIdentifier: Hashable, Equatable {
		case templatesList
	}
	
	struct CellItem: Hashable, Equatable {
		let toastType: ToastType
		
		var id: String { toastType.id }
		var title: String { toastType.title }
		
		func hash(into hasher: inout Hasher) {
			hasher.combine(id)
		}
		
		static func == (lhs: CellItem, rhs: CellItem) -> Bool {
			lhs.id == rhs.id
		}
	}
}

final class ToastsListDiffableDataSource {
	private let templateTypes: [ToastType]
	
	private lazy var diffableDataSource: DiffableDataSource = diffableDataSourceFor(collectionView: collectionView)
	
	let collectionView: UICollectionView
	
	init(collectionView: UICollectionView, templateTypes: [ToastType]) {
		self.collectionView = collectionView
		self.templateTypes = templateTypes
	}
}

extension ToastsListDiffableDataSource {
	func sectionIdentifier(for index: Int) -> SectionIdentifier? {
		diffableDataSource.sectionIdentifier(for: index)
	}
	
	func itemIdentifier(for indexPath: IndexPath) -> CellItem? {
		diffableDataSource.itemIdentifier(for: indexPath)
	}
	
	func toastType<T>(forIndexPath indexPath: IndexPath) -> T? {
		itemIdentifier(for: indexPath)?.toastType as? T
	}
	
	func reloadData(animated: Bool = true, completion: (() -> Void)? = nil) {
		var snapshot: DiffableDataSourceSnapshot = DiffableDataSourceSnapshot()
		
		let templatesCellItems = templateCellItemsFor(templateTypes: templateTypes)
		
		snapshot.appendSections([SectionIdentifier.templatesList])
		snapshot.appendItems(templatesCellItems, toSection: .templatesList)
		
		diffableDataSource.apply(snapshot, animatingDifferences: animated, completion: completion)
	}
}

private extension ToastsListDiffableDataSource {
	func templateCellItemsFor(templateTypes: [ToastType]) -> [CellItem] {
		templateTypes.map { .init(toastType: $0) }
	}
}

private extension ToastsListDiffableDataSource {
	func diffableDataSourceFor(collectionView: UICollectionView) -> DiffableDataSource {
		return DiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
			guard
				let cell: TemplatedToastCell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplatedToastCell.reuseIdentifier, for: indexPath) as? TemplatedToastCell
			else { return nil }
			
			cell.configure(title: itemIdentifier.title)
			
			return cell
		}
	}
}
