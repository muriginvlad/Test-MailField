//
//  ViewController.swift
//  MailField
//
//  Created by Vladislav on 27.03.2022.
//

import UIKit
import AutoCompleteTextField

class ViewController: UIViewController, ACTFDataSource, UITextFieldDelegate {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mailTextFiled: AutoCompleteTextField!
    @IBOutlet weak var enterButton: UIButton!
    
    // MARK: - private variables
    private var networkService = NetworkService()
    private var email = ""
    
    private let domainNames = ["gmail.com",
                               "yahoo.com",
                               "hotmail.com",
                               "aol.com",
                               "comcast.net",
                               "me.com",
                               "msn.com",
                               "live.com",
                               "sbcglobal.net",
                               "ymail.com",
                               "icloud.com"]
    
    private var animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 2
        animation.autoreverses = true
        return animation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Interface setup
    func setupUI(){
        mailTextFiled.delegate = self
        mailTextFiled.dataSource = self
        mailTextFiled.textContentType = .emailAddress
        mailTextFiled.keyboardType = .emailAddress
        mailTextFiled.placeholder = "Enter your email"
        mailTextFiled.clipsToBounds = true
        mailTextFiled.layer.cornerRadius = 10
        mailTextFiled.layer.borderWidth = 2
        mailTextFiled.layer.borderColor = UIColor.gray.cgColor
        mailTextFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        mailTextFiled.setDelimiter("@")

        mainTitle.text = ""
        
        enterButton.setTitle("Enter", for: .normal)
        enterButton.isEnabled = false
        enterButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
    }
    
    // MARK: - Private methods

    @objc private func pressedButton(){
        networkService.getKickboxData(email: email) { [weak self] kickboxResponse, error in
            if kickboxResponse?.resultState == .undeliverable {
                self?.notValidMail()
            } else {
                self?.validMail()
            }
        }
    }
    
    @objc private func textFieldDidChange(textField: UITextField){
        self.mailCheck(email: textField.text)
    }
    
    private func mailCheck(email: String?) {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email?.range( of: emailPattern, options: .regularExpression)
       
        if result != nil {
            self.email = email ?? ""
        }
        enterButton.isEnabled = (result != nil)
    }
    
    private func notValidMail() {
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.mailTextFiled.center.x - 5, y: mailTextFiled.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.mailTextFiled.center.x + 5, y: mailTextFiled.center.y))
        mailTextFiled.layer.add(animation, forKey: "position")
        mailTextFiled.layer.borderColor = UIColor.red.cgColor
        mainTitle.text = "The email entered is not valid :("
    }
    
    private func validMail() {
        mailTextFiled.layer.borderColor = UIColor.green.cgColor
        mainTitle.text = "Email sent!"
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.mailCheck(email: mailTextFiled.text)
        return true
    }
    
    // MARK: - ACTFDataSource
    
    func autoCompleteTextFieldDataSource(_ autoCompleteTextField: AutoCompleteTextField) -> [ACTFDomain] {
        return AutoCompleteTextField.domainNames
    }
}

