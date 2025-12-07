//
//  SearchEventViewController.swift
//  EventSync
//
//  Created by Akash Dhadiwal on 12/02/25.
//

import UIKit

extension LandingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            displayedEvents = events
        } else {
            self.displayedEvents.removeAll()

            displayedEvents = events.filter { event in
                event.name.lowercased().contains(searchText.lowercased())
            }
        }
        updateNoEventTextVisibility(isEmpty: displayedEvents.isEmpty)
        self.landingView.eventTableView.reloadData()
    }
}
