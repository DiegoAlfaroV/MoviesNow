//
//  ViewController.swift
//  moviesnow
//
//  Created by Alfaro, Diego on 8/04/19.
//  Copyright © 2019 IQVIA. All rights reserved.
//

import UIKit

import Reachability

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
        loadMovies()
    }
    
    func loadNavigationBar() {
        NavigationPresenter.createNavigationBar(for: self)
    }
    
    func loadMovies() {
        ifReachable { _ in
            DialogPresenter.showLoading(in: self.view)
            MovieLogic.listar { result in
                if result != nil {
                    self.movies.append(contentsOf: result!)
                    self.tblMovies.reloadData()
                }
                
                DialogPresenter.hideLoading(in: self.view)
            }
        }
    }
    
    func searchMovies() {
        ifReachable { _ in
            DialogPresenter.showLoading(in: nil)
            MovieLogic.buscar(keyword: self.keywords) { result in
                //fill movies with RESULT
                self.movies = result
                self.tblMovies.reloadData()
                
                DialogPresenter.hideLoading(in: nil)
            }
        }
    }
    
    //Change place to ???
    func ifReachable(completion: @escaping (_ result: Bool) -> Void) {
        let reachability = Reachability()
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        if reachability?.connection != Reachability.Connection.none {
            completion(true)
        } else {
            DialogPresenter.showDialog(in: self, message: String.get(key: "errorInternet"))
        }
        
        reachability?.stopNotifier()
    }
    
    //SearchBar Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keywords = searchText
        searchMovies()
    }

    //TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        if indexPath.row == movies.count - 1 {
            loadMovies()
            return UITableViewCell()
        } else {
            return CellFactory.createMovieCell(tableView: tableView, indexPath: indexPath, movie: movie)
        }
        
    }
}

