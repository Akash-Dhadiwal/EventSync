//
//  ProfileViewController.swift
//  EventSync
//
//  Created by mirat shah on 11/17/25.
//


import UIKit

class ProfileViewController: UIViewController {

    override func loadView() {
        self.view = ProfileView(frame: UIScreen.main.bounds)
    }

    private var profileView: ProfileView { return view as! ProfileView }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white

        // fill in placeholder data so UI looks real
        profileView.textFieldEmail.text = "student@example.edu"
        profileView.textFieldName.text = "Esha Chiplunkar"
        // If you want to handle save or edit
        profileView.buttonSave.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }

    @objc private func didTapSave() {
        // no-op for UI demo
        let alert = UIAlertController(title: "Saved", message: "UI-only demo: values not persisted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
