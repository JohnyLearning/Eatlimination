//
//  DietFoodsController-DragDelegate.swift
//  Eatlimination

import Foundation
import UIKit

extension DietFoodsController: UICollectionViewDragDelegate, UIDropInteractionDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let food = self.foods?[indexPath.row]
        let foodProvider = NSItemProvider(object: String(describing: food?.objectID) as NSString)
        let dragItem = UIDragItem(itemProvider: foodProvider)
        dragItem.localObject = food
        return [dragItem]
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if isWithinDropBoundaries(point: session.location(in: self.view)) {
            if let food = session.items[0].localObject as? FoodData {
                if let foods = self.foods {
                    for (index, foodItem) in foods.enumerated() {
                        if foodItem.objectID == food.objectID {
                            self.foods?.remove(at: index)
                            foodDataObject.removeFromDiet(food: food)
                            foodsCollection.reloadData()
                            break
                        }
                    }
                }
            }
        }
    }
    
    private func isWithinDropBoundaries(point: CGPoint) -> Bool {
        return point.y <= self.deletePlace.frame.maxY
            && point.y >= self.deletePlace.frame.minY
            && point.x <= self.deletePlace.frame.maxX
            && point.x >= self.deletePlace.frame.minX
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
     
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: String.self)
    }

}
