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
    var arrayOfMovies: [MovieResult] = []
    var arrayOfSeries: [SeriesResult] = []
    var typeOfMedia: String = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "WatchListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "WatchListTableViewCell")

    }
    
    @IBAction func backToTopPressed(_ sender: Any) {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    func getGenreMedia(mediaType: String, genreID: Int) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/discover/\(typeOfMedia)?api_key=de2fa60445b65225004497a21552b0ce&with_genres=\(genreID)", method: .get)
        if mediaType == "movie" {
            genresRequest.responseDecodable(of: Movies.self) { response in
                do {
                    self.arrayOfMovies = try response.result.get().results
                    self.tableView.reloadData()
                }
                catch {
                    print("error: \(error)")
                }
            }
        } else {
            genresRequest.responseDecodable(of: Series.self) { response in
                do {
                    self.arrayOfSeries = try response.result.get().results
                    self.tableView.reloadData()
                }
                catch {
                    print("error: \(error)")
                }
            }
        }
        

        }
    

}

extension GenreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
        
        if typeOfMedia == "movie" {
            cell.configureMovies(with: arrayOfMovies[indexPath.row])
            return cell
        } else {
            cell.configureSeries(with: arrayOfSeries[indexPath.row])
            return cell
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if typeOfMedia == "movie" {
            return arrayOfMovies.count
        } else {
            return arrayOfSeries.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if typeOfMedia == "movie" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: arrayOfMovies[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureSeries(with: arrayOfSeries[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
