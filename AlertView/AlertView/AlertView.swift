//
//  AlertView.swift
//  AlertView
//
//  Created by Elorce on 30/12/21.
//


import Foundation
import UIKit

class AlertView: UIView {
    
    static let instance = AlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    typealias AlertCompletionHandler = (_ success: Bool) -> ()
    var alertCompletionHandler:AlertCompletionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        imgV.layer.cornerRadius = 30
        imgV.layer.borderColor = UIColor.white.cgColor
        imgV.layer.borderWidth = 2
        
        alertView.layer.cornerRadius = 10
        doneBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType {
        case success
        case failure
    }
    
    func showAlert(title: String,
                   message: String,
                   alertType: AlertType,
                   actionTitles: [String]? = ["Done"],
                   WithAlertCompletionHandler completionHandler:@escaping AlertCompletionHandler) {
        self.titleLbl.text = title
        self.messageLbl.text = message
        
        if actionTitles?.count == 1 {
            cancelBtn.isHidden = true
            doneBtn.setTitle(actionTitles?[0], for: .normal)
            
            switch alertType {
            case .success:
                imgV.image = UIImage(named: "Success")
                doneBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            case .failure:
                imgV.image = UIImage(named: "Failure")
                doneBtn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
        }
        else {
            if(Thread.isMainThread){
                imgV.image = UIImage(named: "Exclamation")
            }else{
                DispatchQueue.main.async {
                    self.imgV.image = UIImage(named: "Exclamation")
                }
            }
            
            doneBtn.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cancelBtn.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cancelBtn.isHidden = false
            
            doneBtn.setTitle(actionTitles?[0], for: .normal)
            cancelBtn.setTitle(actionTitles?[1], for: .normal)
        }
        alertCompletionHandler = completionHandler
        
        if(Thread.isMainThread){
            UIApplication.shared.keyWindow?.addSubview(parentView)
        }else{
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.addSubview(self.parentView)
            }
        }
    }
    
    @IBAction func doneBtnClicked(_ sender: Any) {
        alertCompletionHandler?(true)
        parentView.removeFromSuperview()
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        alertCompletionHandler?(false)
        parentView.removeFromSuperview()
    }
    
}
