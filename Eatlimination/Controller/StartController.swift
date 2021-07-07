//
//  StartController.swift
//  Eatlimination

import UIKit
import CoreData

class StartController: BaseEatliminationController {
    
    var foods = [FoodData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noFoods: UIImageView!

    @IBOutlet weak var activeDietAction: UIBarButtonItem!
    
    @IBOutlet weak var noFoodsDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        updateView()
    }
    
    private func updateView() {
        if let foods = foodDataObject.findFoods() {
            self.foods = foods
        }
        if let activeDiet = dietDataObject.getActiveDiet(), let activeFoods = foodDataObject.findFoods(byDiet: activeDiet), activeFoods.count > 0 {
            self.navigationItem.leftBarButtonItem = self.activeDietAction
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        let hasFoods = foods.count > 0
        tableView.isHidden = !hasFoods
        noFoods.isHidden = hasFoods
        noFoodsDescription.isHidden = hasFoods
    }

    @IBAction func showActiveDietDetails(_ sender: Any) {
        if let dietDetailsTabBar = self.storyboard?.instantiateViewController(withIdentifier: "dietDetailsTabBar") as? DietDetailsTabBar{
            dietDetailsTabBar.modalPresentationStyle = .fullScreen
            dietDetailsTabBar.refreshFoodsDelegate = self
            self.present(dietDetailsTabBar, animated: true)
        }
    }
}

extension StartController: RefreshList {
    func refresh() {
        updateView()
        tableView.reloadData()
    }
}
