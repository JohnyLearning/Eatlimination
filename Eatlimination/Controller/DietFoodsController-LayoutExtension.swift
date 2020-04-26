//
//  DietFoodsController-LayoutExtension.swift
//  Eatlimination

import Foundation
import UIKit

extension DietFoodsController: UICollectionViewDelegateFlowLayout {
 
    static let space: CGFloat = 2.0
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        var numberOfItemsPerRow: CGFloat = 3.0;
        if collectionViewWidth > collectionView.bounds.height {
            // landscape
            numberOfItemsPerRow = 6.0
        }
        let width = floor ((collectionViewWidth - DietFoodsController.space) / numberOfItemsPerRow)
        let height = width

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DietFoodsController.space
    }
 
}

