//
//  MusicPlaylistViewController.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class MusicPlaylistViewController: UIViewController {
    
    var songs = [Song]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goBackFromPlayerController(_ segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate var navColor: UIColor!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navColor = self.navigationController?.navigationBar.tintColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintColor = navColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlayer" {
            let playerViewController = segue.destination as? PlayerViewController
            if let index = tableView.indexPathForSelectedRow?.row {
                playerViewController?.songs = songs
                playerViewController?.songIndex = index
            }
            
        }
    }

}

extension MusicPlaylistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicPlaylistTableViewCell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row].title
        return cell
    }
    
}
