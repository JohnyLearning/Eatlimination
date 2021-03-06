//
//  DietDetailsTabBarBaseController.swift
//  Eatlimination

import Foundation

class BaseDietDetailsTabBarController: BaseEatliminationController {
    
    func goBack() {
        if let dietTabBar = self.tabBarController as? DietDetailsTabBar {
            dietTabBar.refreshFoodsDelegate?.refresh()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
