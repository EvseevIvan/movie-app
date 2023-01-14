//
//  GenreNameCollectionViewCell.swift
//  finalProject
//
//  Created by Иван Евсеев on 18.12.2022.
//

import UIKit

class GenreNameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var nameOfGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
    }
    func configure(name: String){
        nameOfGenre.text = name
    }
}
