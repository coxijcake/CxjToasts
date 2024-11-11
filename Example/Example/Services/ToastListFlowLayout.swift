//
//  ToastListFlowLayout.swift
//  Example
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

final class ToastListFlowLayout : UICollectionViewFlowLayout {
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?
			.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
		
		layoutAttributesObjects?.forEach({ layoutAttributes in
			if layoutAttributes.representedElementCategory == .cell {
				if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
					layoutAttributes.frame = newFrame
				}
			}
		})
		
		return layoutAttributesObjects
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		guard let collectionView = collectionView else {
			assertionFailure()
			return nil
		}
		
		guard
			let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
		else { return nil }
		
		layoutAttributes.frame.origin.x = sectionInset.left
		layoutAttributes.frame.size.width =
		collectionView.safeAreaLayoutGuide.layoutFrame.width
		- sectionInset.left
		- sectionInset.right
		
		return layoutAttributes
	}
}
