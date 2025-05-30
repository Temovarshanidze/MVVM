

import UIKit

class ProfileViewController: UIViewController {
    
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter username/email"
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
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let accountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create New Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSAttributedString(string: NSLocalizedString("Forgot Password?", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAllFuncs()
    }
    
    func callAllFuncs() {
        view.backgroundColor = .cyan
        setupUI()
        addButtonTarget()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        view.addSubview(accountButton)
        view.addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
          //  logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logInButton.widthAnchor.constraint(equalToConstant: 120),
            logInButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            accountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            accountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
//accountButton.widthAnchor.constraint(equalToConstant: 120),
            accountButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgotButton.topAnchor.constraint(equalTo: accountButton.bottomAnchor, constant: 20),
            forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//accountButton.widthAnchor.constraint(equalToConstant: 120),
            forgotButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    func addButtonTarget() {
        accountButton.addAction(UIAction (handler: {[weak self] _ in
            self?.navigationController?.pushViewController(AccountRegistrationViewController(), animated: true)
        }), for: .touchUpInside)
        
        forgotButton.addAction(UIAction (handler: {[weak self] _ in
            self?.navigationController?.pushViewController(PasswordRecoverViewController(), animated: true)
        }), for: .touchUpInside)
    }
}
