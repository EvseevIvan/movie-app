//
//  GenreViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 12.12.2022.
//

import UIKit
import Alamofire

class GenreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var typeOfMedia: String = ""
    let viewModel = GenreViewControllerViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "WatchListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "WatchListTableViewCell")
        
    }
    
    
    @IBAction func backToTopPressed(_ sender: Any) {
        tableView.setContentOffset(.zero, animated: true)
    }
    

}

extension GenreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
        
        if typeOfMedia == "movie" {
            cell.configureMovies(with: viewModel.arrayOfMovies[indexPath.row])
            return cell
        } else {
            cell.configureSeries(with: viewModel.arrayOfSeries[indexPath.row])
            return cell
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if typeOfMedia == "movie" {
            return viewModel.arrayOfMovies.count
        } else {
            return viewModel.arrayOfSeries.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeOfMedia == "movie" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: viewModel.arrayOfMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureSeries(with: viewModel.arrayOfSeries[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
