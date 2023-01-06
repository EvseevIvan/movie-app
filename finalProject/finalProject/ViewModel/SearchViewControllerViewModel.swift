//
//  SearchViewModel.swift
//  finalProject
//
//  Created by Иван Евсеев on 06.01.2023.
//

import Foundation


class SearchViewControllerViewModel {
    
    var arrayOfSearchedMovies: [MovieResult] = []
    var arrayOfSearchedSeries: [SeriesResult] = []
    var filteredArrayOfNames: [String] = []

    
    func searchMovies(query: String, completion: @escaping () -> Void) {
        NetworkManager().searchMovies(query: query) { media in
            self.arrayOfSearchedMovies = media
            completion()
        }
    }
    
    func searchSeries(query: String, completion: @escaping () -> Void) {
        NetworkManager().searchSeries(query: query) { media in
            self.arrayOfSearchedSeries = media
            completion()
        }
    }
    
}
