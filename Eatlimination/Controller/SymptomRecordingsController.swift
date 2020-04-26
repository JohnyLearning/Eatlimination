//
//  SymptomRecordingsController.swift
//  Eatlimination
//
//  Created by Ivan Hadzhiiliev on 2020-04-25.
//

import Foundation
import UIKit

class SymptomRecordingsController: BaseEatliminationController, UITableViewDataSource, UITableViewDelegate {
    
    var symptom: SymptomData? = nil
    @IBOutlet weak var recordingsTable: UITableView!
    private var recordings: [SymptomRecordData]? = nil
    
    override func viewDidLoad() {
        if let symptom = self.symptom {
            recordings = symptomRecordingDataObject.findRecords(bySymptom: symptom)
        }
        recordingsTable.delegate = self
        recordingsTable.dataSource = self
        recordingsTable.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings?.count ?? 0
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SymptomRecordingCell.self), for: indexPath) as? SymptomRecordingCell else {
            fatalError("Unexpected Index Path")
        }

        if let recording = recordings?[indexPath.row] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy @ HH:mm"
            if let description = recording.value, let timestamp = recording.timestamp {
                cell.describtion.text = "\"\(description)\" recorded on \(dateFormatter.string(from: timestamp))"
            }
            if let category = SymptomRecordCategory(rawValue: recording.category) {
                switch category {
                case .green:
                    cell.categoryMark.backgroundColor = .green
                    break
                case .yellow:
                    cell.categoryMark.backgroundColor = .yellow
                    break
                case .red:
                    cell.categoryMark.backgroundColor = .red
                    break
                }
                cell.categoryMark.layer.cornerRadius = 10
                cell.categoryMark.clipsToBounds = true
            }
        }
        return cell
    }
    
}
