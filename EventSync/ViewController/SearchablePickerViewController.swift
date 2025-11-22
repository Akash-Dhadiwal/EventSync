//
//  SearchablePickerViewController.swift
//  EventSync
//
//  Created by mirat shah on 11/22/25.
//

import UIKit

protocol Searchable {
    var name: String { get }
}

class SearchablePickerViewController<T: Searchable>: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var allOptions: [T]
    private var filteredOptions: [T]
    private var selectedOption: T?
    private let notificationName: NSNotification.Name
    let searchablePickerView = SearchablePickerView()

    init(options: [T], selectedOption: T?, notificationName: NSNotification.Name) {
        self.allOptions = options
        self.filteredOptions = options
        self.selectedOption = selectedOption
        self.notificationName = notificationName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchablePickerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // register a reuse identifier so dequeue works
        searchablePickerView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchablePickerView.tableView.delegate = self
        searchablePickerView.tableView.dataSource = self
        searchablePickerView.searchBar.delegate = self
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done", style: .done, target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel", style: .plain, target: self,
            action: #selector(cancelButtonTapped)
        )
    }

    @objc private func doneButtonTapped() {
        guard let selectedOption = selectedOption else { return }
        NotificationCenter.default.post(name: notificationName, object: selectedOption)
        dismiss(animated: true)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredOptions[indexPath.row].name
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = filteredOptions[indexPath.row]
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            filteredOptions = allOptions
        } else {
            let lower = query.lowercased()
            filteredOptions = allOptions.filter { $0.name.lowercased().contains(lower) }
        }
        searchablePickerView.tableView.reloadData()
    }
}
