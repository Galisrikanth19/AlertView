//
//  DashboardViewController.swift
//  AlertView
//
//  Created by Elorce on 30/12/21.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickSuccess(_ sender: Any) {
        AlertView.instance.showAlert(title: "Success",
                                     message: "You are succesfully logged into the system.",
                                     alertType: .success,
                                     //actionTitles: ["Done", "Cancel"],
                                     WithAlertCompletionHandler: { (status) in
            print("success clicked")
        })
    }
}
