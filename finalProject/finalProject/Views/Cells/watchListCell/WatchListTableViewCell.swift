//
//  WatchListTableViewCell.swift
//  finalProject
//
//  Created by Иван Евсеев on 07.12.2022.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfFilm: UIImageView!
    @IBOutlet weak var nameOfFilm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureMovies(with film: MovieResult) {
        nameOfFilm.text = film.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
        imageOfFilm.sd_setImage(with: url, completed: nil)
        imageOfFilm.layer.cornerRadius = 20
    }
    
    func configureSeries(with film: SeriesResult) {
        nameOfFilm.text = film.name
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
        imageOfFilm.sd_setImage(with: url, completed: nil)
        imageOfFilm.layer.cornerRadius = 20
    }
    
}
