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
            downloadImage(foodCell: cell, imageFile: food.imageUrl, index: indexPath)
        }
        return cell
    }
    
    
    private func downloadImage(foodCell: DietFoodCell, imageFile: String?, index: IndexPath) {
        if let imageFile = imageFile {
            foodCell.activityIndicator.startAnimating()
            SpoonacularApi.downloadImage(imageFile: imageFile, size: .size100) { (data, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        foodCell.foodImage?.image = UIImage(data: data as Data)
                    } else {
                        foodCell.foodImage?.image = UIImage(named: "no-image-icon")
                    }
                    foodCell.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
