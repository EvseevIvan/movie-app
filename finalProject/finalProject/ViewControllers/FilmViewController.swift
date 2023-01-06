//
//  FilmViewController.swift
//  finalProject
//
//  Created by Иван Евсеев on 14.11.2022.
//

import UIKit
import Alamofire
import youtube_ios_player_helper

class FilmViewController: UIViewController {
   
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet var trailerPlayer: YTPlayerView!
    @IBOutlet weak var filmGenre: UILabel!
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var addToWatchList: UIButton!
    @IBOutlet weak var filmOverview: UILabel!
    
    var arrayOfTrilers: [Trailer] = []
    var arrayOfMoviesWatchList: [MovieResult] = []
    var arrayOfSeriesWatchList: [SeriesResult] = []
    var arrayOfMovieGenresList: [Genre] = []
    var arrayOfTVGenresList: [Genre] = []
    
    var nameOfFilm: String = ""
    var yearOfFilm: String = ""
    var overviewOfFilm: String = ""
    var imageOfFilm: String = ""
    var genreOfFilm: String = ""
    
    var mediaID: Int = 0
    
    var isItMovie = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmName.text = nameOfFilm
        filmYear.text = yearOfFilm
        filmOverview.text = overviewOfFilm
        filmGenre.text = genreOfFilm
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageOfFilm)")
        filmImage.sd_setImage(with: url, completed: nil)
        
        filmImage.layer.cornerRadius = 10
        addToWatchList.layer.cornerRadius = 8
        addToWatchList.backgroundColor = .green
        
        informationView.layer.cornerRadius = 10

        if isItGuestSession {
            addToWatchList.isHidden = true
        } else {
            addToWatchList.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isItMovie == true {
            getWatchlist(mediaType: "movies") { [self] in
                for watchListFilm in self.arrayOfMoviesWatchList {
                    if watchListFilm.title == self.nameOfFilm {
                        print("lol")
                        self.addToWatchList.backgroundColor = .red
                        self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                    } else {
                        print("sdfsdf")
                        self.deleteFromWatchlist(mediaId: self.mediaID, mediaType: "movie")
                        addToWatchList.backgroundColor = .green
                        addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
                    }
                }
            }
        } else {
            getWatchlist(mediaType: "tv") { [self] in
                for watchListSeries in self.arrayOfSeriesWatchList {
                    if watchListSeries.name == self.nameOfFilm {
                        self.addToWatchList.backgroundColor = .red
                        self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                    } else {
                        self.deleteFromWatchlist(mediaId: self.mediaID, mediaType: "tv")
                        addToWatchList.backgroundColor = .green
                        addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
                    }
                }
            }
        }

    }
    
    func getGenres(mediaType: String, completion: @escaping([Genre]) -> Void) {

        let genresRequest = AF.request("https://api.themoviedb.org/3/genre/\(mediaType)/list?api_key=\(apiKey)&language=en-US", method: .get)
        
        genresRequest.responseDecodable(of: Genres.self) { response in
            do {
                if mediaType == "movie" {
                    self.arrayOfMovieGenresList = try response.result.get().genres
                    let data = try response.result.get().genres
                    completion(data)
                } else {
                    self.arrayOfTVGenresList = try response.result.get().genres
                }
            }
            catch {
                print("error: \(error)")
            }
        }
    }
    
    func configureMovie(with film: MovieResult) {
        getGenres(mediaType: "movie") { genres in
            print(genres)
            for genre in genres {
                if film.genreIDS[0] == genre.id {
                    self.genreOfFilm = "🎭: \(genre.name)"
                }
            }
        }
        let year: String = film.releaseDate ?? ""
        imageOfFilm = film.posterPath
        nameOfFilm = film.title ?? ""
        yearOfFilm = "📆: " + (year.formattedDate(withFormat: "MMM dd, yyyy") ?? "")
        
        overviewOfFilm = film.overview
        mediaID = film.id
        isItMovie = true

        
        getWatchlist(mediaType: "movies") {
            for watchListFilm in self.arrayOfMoviesWatchList {
                if watchListFilm.title == film.title {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                }
            }
        }
        getTrailers(mediaID: film.id, mediaType: "movie") {
            self.trailerPlayer.load(withVideoId: self.arrayOfTrilers[0].key)
        }
    }
    
    func configureSeries(with film: SeriesResult) {
        imageOfFilm = film.posterPath
        nameOfFilm = film.name
        overviewOfFilm = film.overview
        mediaID = film.id
        isItMovie = false
        yearOfFilm = "📆: \(film.firstAirDate)"

        getWatchlist(mediaType: "tv") {
            for watchListFilm in self.arrayOfSeriesWatchList {
                if watchListFilm.name == film.name {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                }
            }
        }

        getTrailers(mediaID: film.id, mediaType: "tv") {
            self.trailerPlayer.load(withVideoId: self.arrayOfTrilers[0].key)
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
    
    func addToWatchList(mediaType: String) {
            let params: Parameters = [
                "media_type": mediaType,
                "media_id": mediaID,
                "watchlist": true
              ]
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist?api_key=de2fa60445b65225004497a21552b0ce&session_id=\(sessionID)", method: .post, parameters: params)
            genresRequest.responseDecodable(of: WatchList.self) { response in }
        }
    
    func getTrailers(mediaID: Int, mediaType: String, completion: @escaping() -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/\(mediaType)/\(mediaID)/videos?api_key=de2fa60445b65225004497a21552b0ce&language=en-US", method: .get)
            genresRequest.responseDecodable(of: Trailers.self) { response in
                do {
                    self.arrayOfTrilers = try response.result.get().results
                    completion()
                }
                catch {
                    print("error: \(error)")
                }
            }
        }
    
    func getWatchlist(mediaType: String, completion: @escaping() -> Void) {
            let genresRequest = AF.request("https://api.themoviedb.org/3/account/\(accounID)/watchlist/\(mediaType)?api_key=de2fa60445b65225004497a21552b0ce&language=en-US&session_id=\(sessionID)&sort_by=created_at.asc&page=1", method: .get)
            if mediaType == "movies" {
                genresRequest.responseDecodable(of: Movies.self) { response in
                    do {
                        self.arrayOfMoviesWatchList = try response.result.get().results
                        completion()
                    }
                    catch {
                        print("error: \(error)")
                    }
                }
            } else {
                genresRequest.responseDecodable(of: Series.self) { response in
                    do {
                        self.arrayOfSeriesWatchList = try response.result.get().results
                        completion()
                    }
                    catch {
                        print("error: \(error)")
                    }
                }

            }

        }
    
    @IBAction func addbuttonPressed(_ sender: Any) {
        if addToWatchList.backgroundColor == .green{
            if isItMovie == true {
                addToWatchList(mediaType: "movie")
                addToWatchList.backgroundColor = .red
                addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
            } else {
                addToWatchList(mediaType: "tv")
                addToWatchList.backgroundColor = .red
                addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
            }
        } else if addToWatchList.backgroundColor == .red {
            if isItMovie == true {
                deleteFromWatchlist(mediaId: mediaID, mediaType: "movie")
                addToWatchList.backgroundColor = .green
                addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
            } else {
                deleteFromWatchlist(mediaId: mediaID, mediaType: "tv")
                addToWatchList.backgroundColor = .green
                addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
            }
        }

    }
    

}

extension String {
    func formattedDate(withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            return outputFormatter.string(from: date)
        }
        return nil
    }
}
