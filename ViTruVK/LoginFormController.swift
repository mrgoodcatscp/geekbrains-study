//
//  ViewController.swift
//  ViTruVK
//
//  Created by Вадим Терехов on 02.02.2021.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)

    }
    
    // Капец, надеюсь, мы будем это изучать подробнее...
    
    @objc func keyboardWasShown (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
            
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkUserInput() {
            return true
        } else {
            showUserErrorMessage()
            return false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    func clearUserFields() -> Void {
        loginField.text = ""
        passwordField.text = ""
    }

    @IBAction func tapLoginButton(_ sender: UIButton) {
        
    }
    
    func checkUserInput() -> Bool {
        guard let login = loginField.text, let password = passwordField.text else {
            return false
        }
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return true
        }
    }
    
    func showUserErrorMessage() -> Void {
        let alert = UIAlertController(title: "Ошибка", message: "Неправильное имя пользователя или пароль", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
        clearUserFields()
    }
}
