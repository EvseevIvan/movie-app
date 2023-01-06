//
//  WatchListViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 07.12.2022.
//

import UIKit
import Alamofire

class WatchListViewController: UIViewController {
    
    @IBOutlet weak var watchListTableView: UITableView!
    var arrayOfMoviesWatchList: [MovieResult] = []
    var arrayOfSeriesWatchList: [SeriesResult] = []

    var mediaID = 0
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isItGuestSession {
            watchListTableView.isHidden = true
        } else {
            watchListTableView.isHidden = false
        }
        
        let nib = UINib(nibName: "WatchListTableViewCell", bundle: nil)
        self.watchListTableView.register(nib, forCellReuseIdentifier: "WatchListTableViewCell")
        watchListTableView.dataSource = self
        watchListTableView.delegate = self
        
        segmentedControl.addUnderlineForSelectedSegment()
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWatchlist(mediaType: "movies")
        getWatchlist(mediaType: "tv")
    }
    
    @IBAction func segmentedPressed(_ sender: Any) {
        watchListTableView.reloadData()
        segmentedControl.changeUnderlinePosition()
    }
    
    
    func getWatchlist(mediaType: String) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist/\(mediaType)?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&session_id=\(sessionID)&sort_by=created_at.asc&page=1", method: .get)
            if mediaType == "movies" {
                genresRequest.responseDecodable(of: Movies.self) { response in
                    do {
                        self.arrayOfMoviesWatchList = try response.result.get().results
                        self.watchListTableView.reloadData()

                    }
                    catch {
                        print("error: \(error)")
                    }
                }
            } else {
                genresRequest.responseDecodable(of: Series.self) { response in
                    do {
                        self.arrayOfSeriesWatchList = try response.result.get().results
                        self.watchListTableView.reloadData()

                    }
                    catch {
                        print("error: \(error)")
                    }
                }

            }

        }

    
    func deleteFromWatchlist(mediaId: Int, mediaType: String) {
            let params: Parameters = [
                "media_type": mediaType,
                "media_id": mediaId,
                "watchlist": false
              ]
        let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist?api_key=de2fa60445b65225004497a21552b0ce&session_id=\(sessionID)", method: .post, parameters: params, encoding: JSONEncoding.default)
            genresRequest.responseDecodable(of: WatchList.self) { response in }
        }
    

}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return arrayOfMoviesWatchList.count
        case 1:
            return arrayOfSeriesWatchList.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureMovies(with: arrayOfMoviesWatchList[indexPath.row])
            return cell
        case 1:
            let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureSeries(with: arrayOfSeriesWatchList[indexPath.row])
            return cell
        default:
            let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as! WatchListTableViewCell
            cell.configureSeries(with: arrayOfSeriesWatchList[indexPath.row])
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let remove = UIContextualAction(style: .normal, title: "Delete") {_,_,_ in
                self.deleteFromWatchlist(mediaId: self.arrayOfMoviesWatchList[indexPath.row].id, mediaType: "movie")
                self.arrayOfMoviesWatchList.remove(at: indexPath.row)
                self.watchListTableView.reloadData()
            }
            remove.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [remove])
        case 1:
            let remove = UIContextualAction(style: .normal, title: "Delete") {_,_,_ in
                self.deleteFromWatchlist(mediaId: self.arrayOfSeriesWatchList[indexPath.row].id, mediaType: "tv")
                self.arrayOfSeriesWatchList.remove(at: indexPath.row)
                self.watchListTableView.reloadData()
            }
            remove.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [remove])
        default:
            return UISwipeActionsConfiguration()
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: arrayOfMoviesWatchList[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureSeries(with: arrayOfSeriesWatchList[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
            viewController.configureMovie(with: arrayOfMoviesWatchList[indexPath.row])
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
