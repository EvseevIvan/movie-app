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
    var viewModel = FilmViewControllerViewModel()
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var addToWatchList: UIButton!
    @IBOutlet weak var filmOverview: UILabel!
    
    
    
    var mediaID: Int = 0
    
    var isItMovie = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmName.text = viewModel.nameOfFilm
        filmYear.text = viewModel.yearOfFilm
        filmOverview.text = viewModel.overviewOfFilm
        filmGenre.text = viewModel.genreOfFilm
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.imageOfFilm)")
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

        
        viewModel.getMoviesWatchList { media in
            if media.count == 0 {
                self.addToWatchList.backgroundColor = .green
                self.addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
            }
            for film in media {
                if self.mediaID == film.id {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                    return
                } else {
                    self.addToWatchList.backgroundColor = .green
                    self.addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
                }
            }
        }

    }
    
    
    func configureMovie(with film: MovieResult) {

        let year: String = film.releaseDate ?? ""
        viewModel.imageOfFilm = film.posterPath
        viewModel.nameOfFilm = film.title ?? ""
        viewModel.yearOfFilm = "📆: " + (year.formattedDate(withFormat: "MMM dd, yyyy") ?? "")
        
        viewModel.overviewOfFilm = film.overview
        mediaID = film.id
        isItMovie = true
        
//        viewModel.getMoviesWatchList() { media in
//            for watchListFilm in self.viewModel.arrayOfMoviesWatchList {
//                if watchListFilm.title == film.title {
//                    self.addToWatchList.backgroundColor = .red
//                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
//                }
//            }
//        }

        viewModel.getGenres(mediaType: "movie") {
            for genre in self.viewModel.arrayOfMovieGenresList {
                if film.genreIDS[0] == genre.id {
                    self.viewModel.genreOfFilm = "🎭: \(genre.name)"
                }
            }
        }
        
        viewModel.getTrailers(mediaType: "movie", mediaID: film.id) {
            self.trailerPlayer.load(withVideoId: self.viewModel.arrayOfTrilers[0].key)
        }
    }
    
    func configureSeries(with film: SeriesResult) {
        
        viewModel.imageOfFilm = film.posterPath
        viewModel.nameOfFilm = film.name
        viewModel.overviewOfFilm = film.overview
        mediaID = film.id
        isItMovie = false
        viewModel.yearOfFilm = "📆: \(film.firstAirDate)"
        
        viewModel.getSeriesWatchList {
            for watchListFilm in self.viewModel.arrayOfMoviesWatchList {
                if watchListFilm.name == film.name {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                }
            }
        }

        viewModel.getTrailers(mediaType: "tv", mediaID: film.id) {
            self.trailerPlayer.load(withVideoId: self.viewModel.arrayOfTrilers[0].key)
        }
    }
    
    
    @IBAction func addbuttonPressed(_ sender: Any) {
        if addToWatchList.backgroundColor == .green{
            if isItMovie == true {
                viewModel.addToWatchList(mediaType: "movie", mediaID: mediaID) {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                }

            } else {
                viewModel.addToWatchList(mediaType: "tv", mediaID: mediaID) {
                    self.addToWatchList.backgroundColor = .red
                    self.addToWatchList.setTitle("Remove from favorites", for: UIControl.State.normal)
                }
            }
        } else if addToWatchList.backgroundColor == .red {
            if isItMovie == true {
                
                viewModel.deleteFromWatchlist(mediaID: mediaID, mediaType: "movie") {
                    self.addToWatchList.backgroundColor = .green
                    self.addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
                }

            } else {
                viewModel.deleteFromWatchlist(mediaID: mediaID, mediaType: "tv") {
                    self.addToWatchList.backgroundColor = .green
                    self.addToWatchList.setTitle("Add to favourites", for: UIControl.State.normal)
                }
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
