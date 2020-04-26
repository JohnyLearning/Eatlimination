//
//  SymptomDetailController.swift
//  Eatlimination

import Foundation
import UIKit

class SymptomDetailController: BaseEatliminationController, UITextFieldDelegate {
    
    weak var onCompleteDelegate: OnComplete?
    
    private var symptom: SymptomData? = nil
    private var statusCategory: SymptomRecordCategory = .green
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symptomImage: UIImageView!
    
    @IBOutlet weak var newValue: UITextField!
    @IBOutlet weak var greenStatus: UIButton!
    @IBOutlet weak var yellowStatus: UIButton!
    @IBOutlet weak var redStatus: UIButton!
    @IBOutlet weak var symptomDescription: UILabel!
    
    
    func prepare(symptom: SymptomData) {
        self.symptom = symptom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        if let symptom = self.symptom {
            if let imageName = symptom.imageName {
                symptomImage.image = UIImage(named: imageName)
            }
            name.text = symptom.name
            resetStatusButtons()
            setStatusButton(button: greenStatus)
            symptomDescription.text = symptom.desc
        }
        newValue.delegate = self
    }
    
    private func setStatusButton(button: UIButton,
                                 background: UIColor? = .green) {
        button.backgroundColor = background ?? .none
        button.addTarget(self, action: #selector(updateStatus(statusButton:)), for: .touchUpInside)
    }
    
    @objc private func updateStatus(statusButton: UIButton) {
        resetStatusButtons()
        switch statusButton.tag {
            case Int(SymptomRecordCategory.green.rawValue):
                setStatusButton(button: greenStatus, background: .green)
                break
            case Int(SymptomRecordCategory.yellow.rawValue):
                setStatusButton(button: yellowStatus, background: .yellow)
                break
            case Int(SymptomRecordCategory.red.rawValue):
                setStatusButton(button: redStatus, background: .red)
                break
            default:
                // noop
                break
        }
        statusCategory = SymptomRecordCategory(rawValue: Int16(statusButton.tag)) ?? SymptomRecordCategory.green
    }
    
    private func resetStatusButtons() {
        setStatusButton(button: greenStatus, background: nil)
        greenStatus.tag = Int(SymptomRecordCategory.green.rawValue)
        greenStatus.layer.cornerRadius = 62
        greenStatus.clipsToBounds = true
        setStatusButton(button: yellowStatus, background: nil)
        yellowStatus.tag = Int(SymptomRecordCategory.yellow.rawValue)
        yellowStatus.layer.cornerRadius = 62
        yellowStatus.clipsToBounds = true
        setStatusButton(button: redStatus, background: nil)
        redStatus.tag = Int(SymptomRecordCategory.red.rawValue)
        redStatus.layer.cornerRadius = 62
        redStatus.clipsToBounds = true
    }
    
    @IBAction func save(_ sender: Any) {
        if let value = newValue.text, !value.isEmpty, let symptom = symptom {
            symptomRecordingDataObject.create(value: value, category: statusCategory, symptom: symptom)
            if let onCompletCallback = onCompleteDelegate {
                onCompletCallback.execute()
            }
            self.navigationController?.popViewController(animated: true)
        } else {
            showError(title: "New recording", message: "Value is required!")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newValue.resignFirstResponder()
        return true
    }
    
}
