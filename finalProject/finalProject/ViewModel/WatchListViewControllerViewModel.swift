//
//  WatchListViewControllerViewModel.swift
//  finalProject
//
//  Created by Иван Евсеев on 06.01.2023.
//

import Foundation

class WatchListViewControllerViewModel {
    
    var arrayOfMoviesWatchList: [MovieResult] = []
    var arrayOfSeriesWatchList: [SeriesResult] = []
    
    func getMoviesWachList(completion: @escaping () -> Void) {
        NetworkManager().getMoviesWatchlist { media in
            self.arrayOfMoviesWatchList = media
            completion()
        }
    }
    
    func getSeriesWachList(completion: @escaping () -> Void) {
        NetworkManager().getSeriesWatchlist { media in
            self.arrayOfSeriesWatchList = media
            completion()
        }
    }
    
    func deleteFromWatchList(mediaID: Int, mediaType: String, completion: @escaping () -> Void) {
        NetworkManager().deleteFromWatchlist(mediaId: mediaID, mediaType: mediaType) {
            completion()
        }
    }

    
}
