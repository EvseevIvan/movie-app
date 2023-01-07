//
//  FilmViewControllerViewModel.swift
//  finalProject
//
//  Created by Иван Евсеев on 07.01.2023.
//

import Foundation


class FilmViewControllerViewModel {
    
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
    
    
    func getTrailers(mediaType: String, mediaID: Int, complpetion: @escaping () -> Void) {
        NetworkManager().getTrailers(mediaID: mediaID, mediaType: mediaType) { trailers in
            self.arrayOfTrilers = trailers
            complpetion()
        }
    }
    
    func addToWatchList(mediaType: String, mediaID: Int, completion: @escaping () -> Void) {
        NetworkManager().addToWatchList(mediaType: mediaType, mediaID: mediaID)
        completion()
    }
    
    func deleteFromWatchlist(mediaID: Int, mediaType: String, completion: @escaping () -> Void) {
        NetworkManager().deleteFromWatchlist(mediaId: mediaID, mediaType: mediaType) { }
        completion()
    }
    
    func getMoviesWatchList(completion: @escaping () -> Void) {
        NetworkManager().getMoviesWatchlist { media in
            self.arrayOfMoviesWatchList = media
        }
        completion()
    }
    func getSeriesWatchList(completion: @escaping () -> Void) {
        NetworkManager().getSeriesWatchlist { media in
            self.arrayOfSeriesWatchList = media
        }
        completion()
    }
    
    func getGenres(mediaType: String, completion: @escaping () -> Void) {
        NetworkManager().getGenres(mediaType: mediaType) { media in
            if mediaType == "movie" {
                self.arrayOfMovieGenresList = media
            } else {
                self.arrayOfTVGenresList = media
            }
        }
        completion()
    }

    
}
