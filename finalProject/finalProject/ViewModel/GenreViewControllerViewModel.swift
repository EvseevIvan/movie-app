//
//  GenreViewControllerViewmodel.swift
//  finalProject
//
//  Created by Иван Евсеев on 06.01.2023.
//

import Foundation


class GenreViewControllerViewModel {
    
    var arrayOfMovies: [MovieResult] = []
    var arrayOfSeries: [SeriesResult] = []
    
    func getMovieMediaByGenre(genreID: Int, completion: @escaping () -> Void) {
        NetworkManager().getMovieGenreMedia(genreID: genreID) { media in
            self.arrayOfMovies = media
            completion()
        }
    }
    
    func getSeriesMediaByGenre(genreID: Int, completion: @escaping () -> Void) {
        NetworkManager().getSeriesGenreMedia(genreID: genreID) { media in
            self.arrayOfSeries = media
            completion()
        }
    }

}
