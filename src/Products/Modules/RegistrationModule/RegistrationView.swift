//
//  RegistrationView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.11.2024.
//

import UIKit
import SnapKit

/// ``IRegistrationView``.
public final class RegistrationView: UIViewController {
    
    // MARK: - UI
    
    /// Представление текстового поля для электронной почты.
    private var emailTextFieldView: PNamedTextFieldView!
    
    /// Представление текстового поля для пароля.
    private var passwordTextFieldView: PNamedTextFieldView!
    
    /// Представление текстового поля для подтверждения пароля.
    private var confirmPasswordTextFieldView: PNamedTextFieldView!
    
    /// Кнопка регистрации.
    private var registerButton: PButton!
    
    // MARK: - Fields
    
    public var presenter: IRegistrationPresenter!
    
    public let assembler: IRegistrationAssembler! = RegistrationAssembler()
    
    // MARK: - View life cycle
    
    /// Представление было загружено.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        assembler.assemble(with: self)
        
        presenter.viewDidLoad()
    }
    
    /// Представление закончило отрисовку дочерних представлений.
    public override func viewDidLayoutSubviews() {
        presenter.viewDidLayoutSubviews()
    }
    
    // MARK: - Private
    
    /// Представление было нажато.
    @objc private func viewTapped() {
        presenter.viewTapped()
    }
    
    /// Кнопка регистрации была нажата.
    @objc private func registerButtonTapped() {
        presenter.registerButtonTapped()
    }
}

// MARK: - IRegistrationView methods extensions
extension RegistrationView: @preconcurrency IRegistrationView {
    
    public func presentLoginView(_ loginView: any ILoginView, animated: Bool) {
        self.navigationController?.pushViewController(loginView as! UIViewController, animated: animated)
    }
    
    public func getEmailValue() -> String? {
        let email = self.emailTextFieldView.getTextFieldValue()
        
        return email
    }
    
    public func getPasswordValue() -> String? {
        let password = self.passwordTextFieldView.getTextFieldValue()
        
        return password
    }
    
    public func getConfirmPasswordValue() -> String? {
        let confirmPassword = self.confirmPasswordTextFieldView.getTextFieldValue()
        
        return confirmPassword
    }
    
    public func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .default)
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
    
    public func hideKeyboard() {
        view.endEditing(true)
    }
    
    public func addViewTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    public func configureShadows() {
        self.registerButton.layer.shadowPath = UIBezierPath(roundedRect: self.registerButton.bounds, cornerRadius: 30).cgPath
    }
    
    public func configureUI() {
        configureView()
        configureEmailTextFieldView()
        configurePasswordTextFieldView()
        configureConfirmPasswordTextFieldView()
        configureRegisterButton()
    }
}

// MARK: - IRegistrationView defaults extensions
extension IRegistrationView {
    
    public func showAlert(title: String = "Ошибка", description: String) {
        self.showAlert(title: title, description: description)
    }
}

// MARK: - Configure UI extensions
extension RegistrationView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Регистрация"
        self.view.backgroundColor = .white
    }
    
    /// Настроить представление текстового поля для электронной почты.
    private func configureEmailTextFieldView() {
        self.emailTextFieldView = PNamedTextFieldView()
        
        self.view.addSubview(self.emailTextFieldView)
        
        self.emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(190)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(73)
        }
        
        self.emailTextFieldView.setName("e-mail")
        self.emailTextFieldView.setTextFieldPlaceholder("example@example.ru")
        self.emailTextFieldView.setTextFieldType(.emailAddress)
    }
    
    /// Настроить представление текстового поля для пароля.
    private func configurePasswordTextFieldView() {
        self.passwordTextFieldView = PNamedTextFieldView()
        
        self.view.addSubview(self.passwordTextFieldView)
        
        self.passwordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextFieldView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(73)
        }
        
        self.passwordTextFieldView.setName("Пароль")
        self.passwordTextFieldView.setTextFieldPlaceholder("******")
        self.passwordTextFieldView.setTextFieldType(.newPassword)
    }
    
    /// Настроить представление текстового поля для подтверждения пароля.
    private func configureConfirmPasswordTextFieldView() {
        self.confirmPasswordTextFieldView = PNamedTextFieldView()
        
        self.view.addSubview(self.confirmPasswordTextFieldView)
        
        self.confirmPasswordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTextFieldView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(73)
        }
        
        self.confirmPasswordTextFieldView.setName("Повторите пароль")
        self.confirmPasswordTextFieldView.setTextFieldPlaceholder("******")
        self.confirmPasswordTextFieldView.setTextFieldType(.password)
    }
    
    /// Настроить кнопку регистарции.
    private func configureRegisterButton() {
        self.registerButton = PButton(text: "Регистрация")
        
        self.view.addSubview(self.registerButton)
        
        self.registerButton.addTarget(self, action: #selector(self.registerButtonTapped), for: .touchUpInside)
        
        self.registerButton.snp.makeConstraints { make in
            make.top.equalTo(self.confirmPasswordTextFieldView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(48)
        }
    }
}
