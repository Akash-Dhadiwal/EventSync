//
//  EventsListViewController 2.swift
//  EventSync
//
//  Created by mirat shah on 11/17/25.
//


import UIKit

class EventsListViewController: UIViewController {

    // Use the SearchablePickerView which contains a searchBar + tableView
    override func loadView() {
        view = SearchablePickerView(frame: UIScreen.main.bounds)
    }

    private var searchableView: SearchablePickerView { return view as! SearchablePickerView }

    // Dummy events for UI preview
    private var allEvents: [(title: String, location: String, datetime: String)] = [
        ("Campus Hack Night", "Student Center", "Nov 20 • 6:30 PM"),
        ("Study Group — ML", "Library 3B", "Nov 21 • 4:00 PM"),
        ("Photography Walk", "Main Quad", "Nov 23 • 10:00 AM"),
        ("Coffee & Code", "Campus Cafe", "Nov 24 • 7:00 PM")
    ]

    // filtered model used by the table
    private var filteredEvents: [(title: String, location: String, datetime: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        view.backgroundColor = .white

        filteredEvents = allEvents

        // table setup
        searchableView.tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        searchableView.tableView.dataSource = self
        searchableView.tableView.delegate = self
        searchableView.tableView.rowHeight = 120
        searchableView.tableView.tableFooterView = UIView()

        // search bar delegate
        searchableView.searchBar.delegate = self

        // small UI polish
        searchableView.searchBar.placeholder = "Search events"
    }
}

// MARK: - UITableViewDataSource
extension EventsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }

        let event = filteredEvents[indexPath.row]
        cell.eventNameLabel.text = event.title
        cell.eventLocationLabel.text = event.location
        cell.eventDateTimeLabel.text = event.datetime
        cell.eventImageView.image = UIImage(systemName: "photo") // placeholder
        cell.eventLikeLabel.text = "12" // placeholder likes

        return cell
    }
}

// MARK: - UITableViewDelegate
extension EventsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)

         // For demo, push Profile screen (you can create EventDetailViewController instead)
         let profileVC = ProfileViewController()
         profileVC.title = "Organizer"
         navigationController?.pushViewController(profileVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension EventsListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty {
            filteredEvents = allEvents
        } else {
            filteredEvents = allEvents.filter {
                $0.title.localizedCaseInsensitiveContains(q) ||
                $0.location.localizedCaseInsensitiveContains(q) ||
                $0.datetime.localizedCaseInsensitiveContains(q)
            }
        }
        searchableView.tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
