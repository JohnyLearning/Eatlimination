//
//  AddSymptomsController.swift
//  Eatlimination

import Foundation
import UIKit

class AddSymptomsController: BaseEatliminationController {
    
    var changesMade: Bool = false
    
    weak var onCompleteDelegate: RefreshList?
    
    var symptoms = [SymptomData]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        if let symptoms = symptomDataObject.getAllSymptoms() {
            self.symptoms = symptoms
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        setupBackButton()
    }
    
    private func setupBackButton() {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left.fill"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc private func goBack(sender: UIBarButtonItem) {
        if changesMade, let refreshCallback = onCompleteDelegate {
            refreshCallback.refresh(doit: true)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
}
