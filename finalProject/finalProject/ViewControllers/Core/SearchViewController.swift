//
//  SearchViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 30.11.2022.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let viewModel = SearchViewControllerViewModel()
    var isSearching = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        
        let nib = UINib(nibName: "WatchListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "WatchListTableViewCell")
        
        segmentedControl.addUnderlineForSelectedSegment()
        
    }
    
    
    @IBAction func segmentedControllPressed(_ sender: Any) {
        tableView.reloadData()
        segmentedControl.changeUnderlinePosition()
    }

    
}



extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.filteredArrayOfNames.removeAll()
            guard let query = searchBar.text else { return }
            viewModel.searchMovies(query: query.trimmingCharacters(in: .whitespaces)) {
                self.tableView.reloadData()
            }
            
            
            if query == "" {
                viewModel.arrayOfSearchedMovies.removeAll()
                tableView.reloadData()
            } else {
                return
            }
        case 1:
            viewModel.filteredArrayOfNames.removeAll()
            guard let query = searchBar.text else { return }
            viewModel.searchSeries(query: query.trimmingCharacters(in: .whitespaces)) {
                self.tableView.reloadData()
            }
            
            if query == "" {
                viewModel.arrayOfSearchedSeries.removeAll()
                tableView.reloadData()
            } else {
                return
            }
        default:
            print("d")
        }
         
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.arrayOfSearchedMovies.count
        case 1:
            return viewModel.arrayOfSearchedSeries.count
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureMovies(with: viewModel.arrayOfSearchedMovies[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureSeries(with: viewModel.arrayOfSearchedSeries[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: viewModel.arrayOfSearchedMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureSeries(with: viewModel.arrayOfSearchedSeries[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: viewModel.arrayOfSearchedMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }

     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

