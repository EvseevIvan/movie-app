//
//  FilmCell.swift
//  finalProject
//
//  Created by Иван Евсеев on 02.11.2022.
//

import UIKit
import SDWebImage

class FilmCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageOfFilm: UIImageView!
    @IBOutlet weak var nameOfFilm: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateOfFilm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateView.layer.cornerRadius = 25
    }
    
    func configure(with film: MovieResult) {
        nameOfFilm.text = film.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
        imageOfFilm.sd_setImage(with: url, completed: nil)
        imageOfFilm.layer.cornerRadius = 9
        rateOfFilm.text = String(round((film.voteAverage * 10)) / 10.0)
        
        if film.voteAverage < 6 {
            rateView.backgroundColor = .red
        } else if film.voteAverage < 7.5 {
            rateView.backgroundColor = .orange
        } else {
            rateView.backgroundColor = UIColor(red: 0, green: 0.63, blue:0, alpha: 1)
        }

    }
    func configureTV(with film: SeriesResult) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath)")
        imageOfFilm.sd_setImage(with: url)
        nameOfFilm.text = film.name
        imageOfFilm.layer.cornerRadius = 9
        rateOfFilm.text = String(round((film.voteAverage * 10)) / 10.0)

        if film.voteAverage < 6 {
            rateView.backgroundColor = .red
        } else if film.voteAverage < 8 {
            rateView.backgroundColor = .orange
        } else {
            rateView.backgroundColor = UIColor(red: 0, green: 0.63, blue:0, alpha: 1)
        }
        
    }
    


}
