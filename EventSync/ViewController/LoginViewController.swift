//
//  LoginViewController.swift
//  EventSync
//
//  Created by mirat shah on 11/17/25.
//


import UIKit

class LoginViewController: UIViewController {

    // Use your custom view
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }

    private var loginView: LoginView { return view as! LoginView }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        setupActions()
    }

    private func setupActions() {
        // login button -> push events list
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)

        // register button -> push register screen
        loginView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }

    @objc private func didTapLogin() {
        // Show next screen (no auth). Push EventsListVC.
        let eventsVC = EventsListViewController()
        navigationController?.pushViewController(eventsVC, animated: true)
    }

    @objc private func didTapRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
