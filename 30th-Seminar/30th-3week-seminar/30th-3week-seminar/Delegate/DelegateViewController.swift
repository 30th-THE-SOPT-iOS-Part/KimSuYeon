//
//  DelegateViewController.swift
//  30th-3week-seminar
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

class DelegateViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var testTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextButtonDidTap(_ sender: Any) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DelegateSecondViewController") as? DelegateSecondViewController else {
            return
        }

        secondViewController.delegate = self

        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension DelegateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트필드 편집 시작")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        testTextField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트필드 편집 끝")
    }
}

extension DelegateViewController: SecondViewControllerDelegate {
    func sendData(data: String) {
        dataLabel.text = data
    }
}
