//
//  MovileCollectionViewCell.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 05/08/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        imageView.backgroundColor = .gray
        descriptionTextView.textContainer.maximumNumberOfLines = 8
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    func renderData(movie: Movie) {
        movieTitleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        descriptionTextView.text = movie.description
    }

}
