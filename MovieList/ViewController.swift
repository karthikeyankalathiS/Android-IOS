//
//  ViewController.swift
//  MovieList
//
//  Created by karthik on 19/02/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var TableView: UITableView!
    var movie = [MovieListResponse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.register(UINib(nibName: "MovieList", bundle: nil), forCellReuseIdentifier: "MovieList")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieList", for: indexPath) as! MovieList
        return cell
    }
    


}

