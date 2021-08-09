//
//  MoviewDetailViewController.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 08/08/21.
//

import UIKit

class MoviewDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private var movie = Movie()
    
    convenience init(movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        render(movie: movie)
    }
    
    func setupView() {
        titleLabel.text = ""
        
    }

    func render(movie: Movie) {
        titleLabel.text = "\(movie.title ?? "") (\(movie.releaseYear ?? ""))"
        directorLabel.text = "Director: \(movie.director ?? "")"
        descriptionTextView.text = movie.description
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
