//
//  RegisterViewController.swift
//  EventSync
//
//  Created by mirat shah on 11/17/25.
//


import UIKit

class RegisterViewController: UIViewController {

    // Simple placeholder view — reuse LoginView or create a small register view.
    private let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Register Screen (UI only)"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 20)
        return l
    }()

    private let continueButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Continue", for: .normal)
        b.layer.cornerRadius = 8
        b.backgroundColor = .systemBlue
        b.setTitleColor(.white, for: .normal)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Register"
        view.addSubview(label)
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            continueButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 140),
            continueButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        continueButton.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
    }

    @objc private func didTapContinue() {
        // After "register", go to events list just for demo
        let eventsVC = EventsListViewController()
        navigationController?.pushViewController(eventsVC, animated: true)
    }
}
