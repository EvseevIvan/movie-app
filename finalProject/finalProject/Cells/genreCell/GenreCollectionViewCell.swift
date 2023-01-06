//
//  GenreCollectionViewCell.swift
//  finalProject
//
//  Created by Иван Евсеев on 11.12.2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var nameOfGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 9
    }
    func configure(name: String){
        nameOfGenre.text = name
    }
}
