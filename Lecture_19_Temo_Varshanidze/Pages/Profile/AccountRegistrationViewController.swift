
import UIKit

class AccountRegistrationViewController: UIViewController {
    
    var isChecked = false
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat Password"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        return button
    }()
    
    let privacyLabel: UILabel = {
        let label = UILabel()
         label.text = "By signing up, you agree to our "
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let privacePolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: NSLocalizedString("Privacy&Policy", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    let checkboxButton: UIButton = {
        let checkboxButton = UIButton()
        checkboxButton.setTitle("☐", for: .normal) // Not checked
        checkboxButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        checkboxButton.setTitleColor(.black, for: .normal)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        return checkboxButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAllFunction()
    }
    
    func callAllFunction() {
        view.backgroundColor = .red
        setUpUi()
        setUpButtons()
    }
    
    func setUpUi() {
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(privacePolicyButton)
        view.addSubview(privacyLabel)
        view.addSubview(checkboxButton)
        view.addSubview(createButton)
        
        /*
       
        let attributedString = NSMutableAttributedString.init(string: "Privacy Policy")
               
               // Add Underline Style Attribute.
               attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                   NSRange.init(location: 0, length: attributedString.length));
        privacyLabel.attributedText = attributedString
         
         */
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            usernameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            repeatPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repeatPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            checkboxButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            checkboxButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            //checkboxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //checkboxButton.heightAnchor.constraint(equalToConstant: 15),
            
            privacyLabel.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            privacyLabel.leftAnchor.constraint(equalTo: checkboxButton.rightAnchor, constant: 5),
           // privacyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            privacyLabel.heightAnchor.constraint(equalToConstant: 41),
            
            privacePolicyButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 10),
            privacePolicyButton.leftAnchor.constraint(equalTo: privacyLabel.rightAnchor, constant: 5),
            //privacePolicyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            privacePolicyButton.heightAnchor.constraint(equalToConstant: 41),
            
            createButton.topAnchor.constraint(equalTo: privacePolicyButton.bottomAnchor, constant: 20),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 120),
            createButton.heightAnchor.constraint(equalToConstant: 40),
            ])
            
    }
    func setUpButtons() {
        privacePolicyButton.addAction(UIAction (handler: {[weak self] _ in
            self?.navigationController?.pushViewController(PrivacyAndPolicyViewController(), animated: true) }), for: .touchUpInside)
        checkboxButton.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        createButton.addAction(UIAction (handler: { [weak self] _ in
            if self?.isChecked == false {
                let alert = UIAlertController(
                    title: "Error", message: "Pleas mark the checkbox", preferredStyle: .alert
                )
                
                let action = UIAlertAction(title: "OK", style: .default) { _ in }
                alert.addAction(action)
                self?.present(alert, animated: true , completion: nil)
                return
            }
        }), for: .touchUpInside)
    }
    
    
    @objc func toggleCheckbox(sender: UIButton) {
          isChecked.toggle() // Toggle the checked state
          if isChecked {
              sender.setTitle("☑", for: .normal) // Checked state
          } else {
              sender.setTitle("☐", for: .normal) // Unchecked state
          }
      }

}

import SwiftUI

#Preview {
    AccountRegistrationViewController()
}
