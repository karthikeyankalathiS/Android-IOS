//
//  Movies.swift
//  MovieList
//
//  Created by karthik on 19/02/24.
//

import UIKit

class Movies: UICollectionViewCell {

    @IBOutlet var Image: UIImageView!
    @IBOutlet var MovieName: UILabel!
    @IBOutlet var Year: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        Image.layer.cornerRadius = Image.frame.width / 8
        Image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        Image.clipsToBounds = true

    }

}
