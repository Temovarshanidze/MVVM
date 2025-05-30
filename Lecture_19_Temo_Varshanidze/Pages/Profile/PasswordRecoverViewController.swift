

import UIKit

class PasswordRecoverViewController: UIViewController {
    
    private let recoveryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter username or email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("reset", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAllFuncs()
        
    }
    
    func callAllFuncs() {
        view.backgroundColor = .systemYellow
        setUpUI()
        setUpButtons()
    }
    func setUpUI() {
        view.addSubview(recoveryTextField)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            recoveryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            recoveryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            recoveryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            resetButton.topAnchor.constraint(equalToSystemSpacingBelow: recoveryTextField.bottomAnchor, multiplier: 5),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),])
    }
    
    func setUpButtons() {
        resetButton.addAction(UIAction (handler: {[weak self] _ in
            let alert = UIAlertController(
                title: "Message", message: "Temporary password has been sent to your email", preferredStyle: .alert
            )
            let action = UIAlertAction(title: "OK", style: .default) { _ in }
            alert.addAction(action)
            self?.present(alert, animated: true , completion: nil)
            return
        }), for: .touchUpInside)
    }
}
