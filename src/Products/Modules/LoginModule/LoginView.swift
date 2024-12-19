//
//  LoginView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import UIKit

/// ``ILoginView``.
public final class LoginView: UIViewController {
    
    // MARK: - UI
    
    /// Представление именованного текстового поля для email.
    private var emailTextFieldView: PNamedTextFieldView!
    
    /// Представление именованного текстового поля для пароля.
    private var passwordTextFieldView: PNamedTextFieldView!
    
    /// Кнопка авторизации.
    private var loginButton: PButton!
    
    // MARK: - Fields
    
    /// ``ILoginPresenter``.
    public var presenter: ILoginPresenter!
    
    /// ``ILoginAssembler``.
    public var assembler: ILoginAssembler = LoginAssembler()
    
    // MARK: - View lifecycle
    
    /// Представление было загружено.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        assembler.assemble(with: self)
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Private
    
    /// Представление было нажато.
    @objc private func viewTapped() {
        presenter.viewTapped()
    }
    
    /// Кнопка авторизации была нажата.
    @objc private func loginButtonTapped() {
        presenter.loginButtonTapped()
    }
}

// MARK: - ILoginView extensions
extension LoginView: @preconcurrency ILoginView {
    
    public func showNearestStoresView(_ nearestStoresView: INearestStoresView, animated: Bool) {
        self.navigationController?.pushViewController(nearestStoresView as! UIViewController, animated: true)
    }
    
    public func getEmailValue() -> String? {
        let email = self.emailTextFieldView.getTextFieldValue()
        
        return email
    }
    
    public func getPasswordValue() -> String? {
        let password = self.passwordTextFieldView.getTextFieldValue()
        
        return password
    }
    
    public func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .default)
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
    
    public func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    public func addViewTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    public func configureUI() {
        configureView()
        configureEmailTextFieldView()
        configurePasswordTextFieldView()
        configureLoginButton()
    }
}

// MARK: - ILoginView defaults extensions
extension ILoginView {
    
    public func showAlert(title: String = "Ошибка", description: String) {
        self.showAlert(title: title, description: description)
    }
}

// MARK: - Configure UI extensions
extension LoginView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Вход"
        self.view.backgroundColor = .white
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    /// Настроить представление именованного текстового поля для email.
    private func configureEmailTextFieldView() {
        self.emailTextFieldView = PNamedTextFieldView()
        
        self.view.addSubview(self.emailTextFieldView)
        
        self.emailTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(73)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(190)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
        
        self.emailTextFieldView.setName("e-mail")
        self.emailTextFieldView.setTextFieldType(.emailAddress)
        self.emailTextFieldView.setTextFieldPlaceholder("example@example.ru")
    }
    
    /// Настроить представление именованного текстового поля для пароля.
    private func configurePasswordTextFieldView() {
        self.passwordTextFieldView = PNamedTextFieldView()
        
        self.view.addSubview(self.passwordTextFieldView)
        
        self.passwordTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(73)
            make.top.equalTo(self.emailTextFieldView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
        
        self.passwordTextFieldView.setName("Пароль")
        self.passwordTextFieldView.setTextFieldType(.password)
        self.passwordTextFieldView.setTextFieldPlaceholder("******")
    }
    
    /// Настроить кнопку авторизации.
    private func configureLoginButton() {
        self.loginButton = PButton(text: "Войти")
        
        self.view.addSubview(self.loginButton)
        
        self.loginButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(self.passwordTextFieldView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
        
        self.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
    }
}
