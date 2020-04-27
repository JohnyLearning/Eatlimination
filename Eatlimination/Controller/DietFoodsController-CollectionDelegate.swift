//
//  DietDetailsController-FoodsTableDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension DietFoodsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DietFoodCell.self), for: indexPath) as? DietFoodCell else {
            fatalError("Unexpected Index Path")
        }
        if let food = foods?[indexPath.row] {
            cell.name.text = food.title
            downloadImage(imageFile: food.imageUrl, activityIndicator: cell.activityIndicator) { imageData in
                if let _ = imageData {
                    cell.foodImage?.image = imageData
                }
            }
        }
        return cell
    }
    
}
