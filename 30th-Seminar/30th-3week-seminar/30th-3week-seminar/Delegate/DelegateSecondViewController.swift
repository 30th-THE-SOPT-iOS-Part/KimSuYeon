//
//  DelegateSecondViewController.swift
//  30th-3week-seminar
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

protocol SecondViewControllerDelegate {
    func sendData(data: String)
}

class DelegateSecondViewController: UIViewController {
    @IBOutlet weak var dataTextField: UITextField!

    var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonDidTap(_ sender: Any) {
        if let text = dataTextField.text {
            delegate?.sendData(data: text)
        }
        self.navigationController?.popViewController(animated: true)
    }


}
