//
//  ViewControllerViewModel.swift
//  finalProject
//
//  Created by Иван Евсеев on 03.01.2023.
//

import Foundation
import Alamofire

class ViewControllerViewModel {
   
    var arrayOfTrandingMovies: [MovieResult] = []
    var arrayOfTopRatedMovies: [MovieResult] = []
    var arrayOfPopularMovies: [MovieResult] = []
    var arrayOfUpcomingMovies: [MovieResult] = []
    
    var arrayOfTrandingSeries: [SeriesResult] = []
    var arrayOfPopularSeries: [SeriesResult] = []
    var arrayOfTopRatedSeries: [SeriesResult] = []
    var arrayOfUpcomingSeries: [SeriesResult] = []
    
    var arrayOfMovieGenresList: [Genre] = []
    var arrayOfTVGenresList: [Genre] = []
    
    public func getGenres(completion: @escaping () -> Void) {
        NetworkManager().getGenres(mediaType: "movie") { genres in
            self.arrayOfMovieGenresList = genres
            completion()
        }
        NetworkManager().getGenres(mediaType: "tv") { genres in
            self.arrayOfTVGenresList = genres
            completion()
        }
    }

    
    public func getPopularMovies(completion: @escaping () -> Void) {
        NetworkManager().getPopularMovies() { data in
            self.arrayOfPopularMovies.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getPopularSeries(completion: @escaping () -> Void) {
        NetworkManager().getPopularSeries() { data in
            self.arrayOfPopularSeries.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getTopRatedMovies(completion: @escaping () -> Void) {
        NetworkManager().getTopRatedMovies() { data in
            self.arrayOfTopRatedMovies.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getTopRatedSeries(completion: @escaping () -> Void) {
        NetworkManager().getTopRatedSeries() { data in
            self.arrayOfTopRatedSeries.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getTrandingMovies(completion: @escaping () -> Void) {
        NetworkManager().getTrandingMovies() { data in
            self.arrayOfTrandingMovies.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getTrandingSeries(completion: @escaping () -> Void) {
        NetworkManager().getTrandingSeries() { data in
            self.arrayOfTrandingSeries.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getUpcomingMovies(completion: @escaping () -> Void) {
        NetworkManager().getUpcomingMovies() { data in
            self.arrayOfUpcomingMovies.insert(contentsOf: data, at: 0)
            completion()
        }
    }
    
    public func getUpcomingSeries(completion: @escaping () -> Void) {
        NetworkManager().getUpcomingSeries() { data in
            self.arrayOfUpcomingSeries.insert(contentsOf: data, at: 0)
            completion()
        }
    }
}
