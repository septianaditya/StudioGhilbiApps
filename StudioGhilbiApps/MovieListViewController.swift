//
//  MovieListViewController.swift
//  StudioGhilbiApps
//
//  Created by Septian-GLI on 04/08/21.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    private var searchKey = ""
    private var movieList: [MovieModel] = []

    convenience init(searchKey: String, list: [MovieModel]) {
        self.init()
        self.searchKey = searchKey
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.text = searchKey
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
