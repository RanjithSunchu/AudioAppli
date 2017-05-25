//
//  HomeViewController.swift
//  MusicApp
//
//  Created by HungDo on 7/24/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var musics:  [String] = ["music-0", "music-1", "music-2", "music-3", "music-4"]
    var singers: [String] = ["singer-0", "singer-1", "singer-2", "singer-3", "singer-4"]
    var albums:  [String] = ["album-0", "album-1", "album-2", "album-3", "album-4"]
    
    var summaryArray: [[[String]]] = [
        // Offline - summaryArray[0]
        [
            // Song                     - summaryArray[0][0]
            ["song1", "song2"],
            // Singer                   - summaryArray[0][1]
            ["singer1", "singer2"],
            // Playlist                 - summaryArray[0][2]
            ["playlist1", "playlist2"]
        ],
        // Online - summaryArray[1]
        [
            // Song                     - summaryArray[1][0]
            ["song1", "song2"],
            // Singer                   - summaryArray[1][1]
            ["singer1", "singer2"],
            // Playlist                 - summaryArray[1][2]
            [
                "playlist1",         // - summaryArray[1][2][0]
                "playlist2"          // - summaryArray[1][2][1]
            ]
        ]
    ]
    
    lazy var twoDimensionalViewArrays: [[String]] = {
        return [self.musics, self.singers, self.albums]
    }()
    
    lazy var threeDimensionalViewArrays: [[[String]]] = {
        return [self.twoDimensionalViewArrays, self.twoDimensionalViewArrays]
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMusicPlaylist" {
            let musicPlaylistVC = segue.destination as? MusicPlaylistViewController
            musicPlaylistVC?.songs = Song.getSamplePlaylist()
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 1 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath)
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textColor = UIColor.red
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = "Playlist \(indexPath.row)"
            cell.detailTextLabel?.text = "1"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Online"
        case 1: return "Offline"
        default: return nil
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performSegue(withIdentifier: "ShowMusicPlaylist", sender: tableView.cellForRow(at: indexPath))
        } else if indexPath.section == 2 {
            self.moveToLoginViewController()
        }
    }
    
    fileprivate func moveToLoginViewController() {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Controllers.LoginController) as? LoginViewController {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.player.destroy()
                appDelegate.window?.rootViewController = loginViewController
            }
        }
    }
    
}
