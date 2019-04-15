//
//  ViewController.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,
                            UITableViewDelegate,
                            UITableViewDataSource,
                            UISearchBarDelegate {
    
    //UI Controls
    @IBOutlet weak var tblMovies: UITableView!
    
    //Attributes
    var movies: [Movie] = [Movie]()
    var keywords: String = ""
    
    //Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNavigationBar()
        loadData()
    }
    
    func loadNavigationBar() {
        NavigationPresenter.createNavigationBar(for: self)
    }
    
    func loadData() {
        DialogPresenter.showLoading(in: self.view)
            
        MovieLogic.obtener(keywords: self.keywords, completion: { result in
            if result.count > 0 {
                self.movies.append(contentsOf: result)
                self.tblMovies.reloadData()
            }
                
            DialogPresenter.hideLoading(in: self.view)
        })
    }
    
    func populateList(isNewSearch: Bool) {
        DialogPresenter.showLoading(in: nil)
        MovieLogic.obtener(keywords: self.keywords, completion: { result in
            if result.count > 0 {
                if isNewSearch {
                    self.movies = []
                }
                    
                self.movies.append(contentsOf: result)
                self.tblMovies.reloadData()
            }
                
            DialogPresenter.hideLoading(in: nil)
        })
    }
    
    //SearchBar Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keywords = searchText
        populateList(isNewSearch: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    //TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        if indexPath.row == movies.count - 1 {
            populateList(isNewSearch: false)
            return CellFactory.createLoadingCell(tableView: tableView, indexPath: indexPath)
        } else {
            return CellFactory.createMovieCell(tableView: tableView, indexPath: indexPath, movie: movie)
        }
    }
}

