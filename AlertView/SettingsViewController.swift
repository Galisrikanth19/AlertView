//
//  SettingsViewController.swift
//  CustomAlert
//
//  Created by Elorce on 30/12/21.
//  Copyright © 2021 SHUBHAM AGARWAL. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickFailure(_ sender: Any) {
        AlertView.instance.showAlert(title: "Success",
                                     message: "You have succesfully logged into the system.",
                                     alertType: .failure,
                                     actionTitles: ["Male", "Female"],
                                     WithAlertCompletionHandler: { (status) in
            if status {
                //Male clicked
            } else {
                //Female clicked
            }
        })
    }

}
