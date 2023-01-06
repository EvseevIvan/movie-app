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
    var arrayOfSearchedMovies: [MovieResult] = []
    var arrayOfSearchedSeries: [SeriesResult] = []
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var filteredArrayOfNames: [String] = []
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
    
    
    func search(query: String, mediaType: String) {
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            let movieRequest = AF.request("https://api.themoviedb.org/3/search/\(mediaType)?api_key=de2fa60445b65225004497a21552b0ce&page=1&query=\(query)", method: .get)
        if mediaType == "tv" {
            movieRequest.responseDecodable(of: Series.self) { responce in
                do {
                    self.arrayOfSearchedSeries = try responce.result.get().results
                    self.tableView.reloadData()
       
                } catch {
                    print(error)
                }
            }
        } else {
            movieRequest.responseDecodable(of: Movies.self) { responce in
                    do {
                        self.arrayOfSearchedMovies = try responce.result.get().results
                        self.tableView.reloadData()
           
                    } catch {
                        print(error)
                    }
                }
           }
        }

    
}



extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.filteredArrayOfNames.removeAll()
            guard let query = searchBar.text else { return }
            search(query: query.trimmingCharacters(in: .whitespaces), mediaType: "movie")
            
            if query == "" {
                arrayOfSearchedMovies.removeAll()
                tableView.reloadData()
            } else {
                return
            }
        case 1:
            self.filteredArrayOfNames.removeAll()
            guard let query = searchBar.text else { return }
            search(query: query.trimmingCharacters(in: .whitespaces), mediaType: "tv")
            
            if query == "" {
                arrayOfSearchedSeries.removeAll()
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
            return arrayOfSearchedMovies.count
        case 1:
            return arrayOfSearchedSeries.count
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureMovies(with: arrayOfSearchedMovies[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureSeries(with: arrayOfSearchedSeries[indexPath.row])
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
            viewController.configureMovie(with: arrayOfSearchedMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureSeries(with: arrayOfSearchedSeries[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: arrayOfSearchedMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }

     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

