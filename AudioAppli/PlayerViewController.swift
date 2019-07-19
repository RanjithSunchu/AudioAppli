//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by HungDo on 7/25/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // MARK: Models
    
    var songs = [Song]()
    var songIndex: Int!

    // MARK: Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var currentSongView: UIView!
    @IBOutlet weak var nextSongView: UIView!
    
    @IBOutlet weak var currentCoverImageView: UIImageView!
    @IBOutlet weak var nextCoverImageView: UIImageView!
    
    @IBOutlet weak var currentSongNameLabel: UILabel!
    @IBOutlet weak var nextSongNameLabel: UILabel!
    
    @IBOutlet weak var currentSingerLabel: UILabel!
    @IBOutlet weak var nextSingerLabel: UILabel!
    
    @IBOutlet weak var currentSongViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextSongViewCenterXConsraint: NSLayoutConstraint!
    
    @IBOutlet weak var playButton: CircleStrokeButton!
    @IBOutlet weak var backwardButton: CircleStrokeButton!
    @IBOutlet weak var forwardButton: CircleStrokeButton!
    @IBOutlet weak var backButton: CircleStrokeButton!
    
    @IBOutlet weak var muteSpeakerImageView: UIImageView!
    @IBOutlet weak var speakerImageView: UIImageView!
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var durationSlider: UISlider!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func playOrPauseButtonTapped(_ button: CircleStrokeButton) {
        if button.currentTitle == "Play" {
            button.setTitle("Pause", for: UIControl.State())
            button.image = UIImage(named: "pause")
            play()
            startRotatingCoverImage()
        } else if button.currentTitle == "Pause" {
            button.setTitle("Play", for: UIControl.State())
            button.image = UIImage(named: "play")
            pause()
            stopRotatingCoverImage()
        }
    }
    
    @IBAction func backButtonTapped() {
        destroyTimer()
        stopRotatingCoverImage()
        animateLabelTransitionsWithDirection(.fromLeft) {
            self.back()
            self.setupAudioPlayer()
            self.setupTimer()
        }
    }
    
    @IBAction func nextButtonTapped() {
        destroyTimer()
        stopRotatingCoverImage()
        animateLabelTransitionsWithDirection(.fromRight) {
            self.next()
            self.setupAudioPlayer()
            self.setupTimer()
        }
    }
    
    @IBAction func volumeSliderValueChanged(_ slider: UISlider) {
        player.volume = slider.value
    }
    
    @IBAction func durationSliderValueChanged(_ slider: UISlider) {
        player.currentTime = TimeInterval(slider.value)
    }
    
    // MARK: Music Player Center
    
    var player: MusicPlayerCenter {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.player
    }
    
    fileprivate func play() {
        player.playWithSong(songs[songIndex])
    }
    
    fileprivate func pause() {
        player.pause()
    }
    
    fileprivate func back() {
        player.playWithSong(songs[songIndex])
    }
    
    fileprivate func next() {
        player.playWithSong(songs[songIndex])
    }
    
    fileprivate func setupAudioPlayer() {
        if player.state != .paused || player.playingSong?.title != songs[songIndex].title {
            play()
        }
        
        durationSlider.minimumValue = 0.0
        durationSlider.maximumValue = Float(player.duration)
        durationSlider.value = Float(player.currentTime)
        
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        volumeSlider.value = player.volume
        
        playButton.setTitle("Pause", for: UIControl.State())
        playButton.image = UIImage(named: "pause")
        
        if player.playing {
            startRotatingCoverImage()
        }
    }
    
    // MARK: View Controller Life Cyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        setupCoverImageView()
        updateSongLabel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        updateCurrentSongViewInfo(songIndex ?? 0)
        updateNextSongViewInfo(nextSongIndex)
        updateBackgroundImage(songIndex ?? 0)
        
        setupAudioPlayer()
        setupTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        destroyTimer()
    }
    
    // MARK: NSTimer Scheduler
    
    fileprivate var timer: Timer?
    fileprivate var timerDuration: TimeInterval = 0.2
    
    fileprivate func setupTimer() {
        destroyTimer()
        timer = Timer.scheduledTimer(timeInterval: timerDuration, target: self, selector: #selector(scheduler(_:)), userInfo: nil, repeats: true)
    }
    
    fileprivate func destroyTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scheduler(_ timer: Timer) {
        durationSlider.value = Float(player.currentTime)
        
        let startedTime = player.startedTime
        let remainingTime = player.remainingTime
        
        startTimeLabel.text = String(format: "%02d:%02d", startedTime.minute, startedTime.second)
        endTimeLabel.text = String(format: "%02d:%02d", remainingTime.minute, remainingTime.second)
        
        if remainingTime.minute == 0 && remainingTime.second < 2 {
            nextButtonTapped()
        }
    }
    
    // MARK: Setup funtions
    
    fileprivate func setupUI() {
        nextSongView.alpha = 0
        
        backwardButton.circleWith = 1
        forwardButton.circleWith  = 1
        
        backwardButton.imageOffset = 0.5
        forwardButton.imageOffset  = 0.5
        
        playButton.image        = UIImage(named: "play")
        backwardButton.image    = UIImage(named: "backward")
        forwardButton.image     = UIImage(named: "forward")
        
        backButton.image = UIImage(named: "back")
        backButton.circleWith = 1
        backButton.imageOffset = 0.6
        
        muteSpeakerImageView.image = UIImage(named: "mute")?.imageWithColor(UIColor.white)
        speakerImageView.image = UIImage(named: "speaker")?.imageWithColor(UIColor.white)
    }
    
    fileprivate func setupCoverImageView() {
        let radius = self.view.bounds.width / 3
        
        currentCoverImageView.layer.cornerRadius = radius
        currentCoverImageView.clipsToBounds = true
        
        nextCoverImageView.layer.cornerRadius = radius
        nextCoverImageView.clipsToBounds = true
    }
    
    // MARK: Increase and Decrease Song Index
    
    fileprivate func increaseSongIndex() {
        songIndex = songIndex + 1
        if songIndex == songs.count {
            songIndex = 0
        }
    }
    
    fileprivate func decreaseSongIndex() {
        songIndex = songIndex - 1
        if songIndex < 0 {
            songIndex = songs.count - 1
        }
    }
    
    fileprivate var nextSongIndex: Int {
        let nextIndex = songIndex + 1
        if nextIndex == songs.count { return 0 }
        return nextIndex
    }
    
    fileprivate var previousSongIndex: Int {
        let previousIndex = songIndex - 1
        if previousIndex < 0 { return songs.count - 1 }
        return previousIndex
    }
    
    // MARK: Update The Current and The Next Song View
    
    fileprivate func updateCurrentSongViewInfo(_ index: Int) {
        let song = songs[index]
        let image = UIImage(named: song.imageURL ?? "default")
        
        currentCoverImageView.image = image
        currentSongNameLabel.text = song.title
        currentSingerLabel.text = song.singer
    }
    
    fileprivate func updateNextSongViewInfo(_ index: Int) {
        let song = songs[index]
        let image = UIImage(named: song.imageURL ?? "default")
        
        nextCoverImageView.image = image
        nextSongNameLabel.text = song.title
        nextSingerLabel.text = song.singer
    }
    
    fileprivate var backgroundImage: UIImage? {
        get {
            return backgroundImageView.image
        }
        set(newImage) {
            backgroundImageView.image = newImage
        }
    }
    
    fileprivate func updateBackgroundImage(_ index: Int) {
        backgroundImage = UIImage(named: songs[index].imageURL ?? "default")
    }
    
    // MARK: The Animation of the song image, name, and singer name
    
    fileprivate enum SongViewDirection {
        case fromLeft
        case fromRight
    }
    
    fileprivate let songViewDuration: TimeInterval = 0.5
    
    fileprivate func updateSongLabel(_ direction: SongViewDirection = .fromLeft) {
        let screenWidth = view.frame.width
        
        switch direction {
        case .fromLeft:
            nextSongViewCenterXConsraint.constant = -screenWidth
        case .fromRight:
            nextSongViewCenterXConsraint.constant = +screenWidth
        }
        
        currentSongViewCenterXConstraint.constant = 0
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func animateLabelTransitionsWithDirection(_ direction: SongViewDirection, completion: @escaping () -> Void) {
        let screenWidth = view.frame.width
        
        updateSongLabel(direction)
        
        switch direction {
        case .fromLeft:
            currentSongViewCenterXConstraint.constant += screenWidth
            updateNextSongViewInfo(previousSongIndex)
        case .fromRight:
            currentSongViewCenterXConstraint.constant -= screenWidth
            updateNextSongViewInfo(nextSongIndex)
        }
        
        nextSongViewCenterXConsraint.constant = 0
        
        UIView.animate(withDuration: songViewDuration, delay: 0, options: [], animations: {
            self.currentSongView.alpha = 0
            self.nextSongView.alpha = 1
            
            self.view.layoutIfNeeded()
        }) { _ in
            switch direction {
            case .fromLeft:
                self.updateBackgroundImage(self.previousSongIndex)
                self.decreaseSongIndex()
            case .fromRight:
                self.updateBackgroundImage(self.nextSongIndex)
                self.increaseSongIndex()
            }
            
            swap(&self.currentCoverImageView            , &self.nextCoverImageView)
            swap(&self.currentSongNameLabel             , &self.nextSongNameLabel)
            swap(&self.currentSingerLabel               , &self.nextSingerLabel)
            swap(&self.currentSongView                  , &self.nextSongView)
            swap(&self.currentSongViewCenterXConstraint , &self.nextSongViewCenterXConsraint)
            
            self.updateSongLabel(direction)
            
            completion()
        }
    }
    
    // MARK: Rotate the song image
    
    fileprivate var rotationTimer: Timer!
    fileprivate var duration: TimeInterval = 6
    
    fileprivate func startRotatingCoverImage() {
        rotationTimer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(rotateCoverImageWithNSTimer(_:)), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopRotatingCoverImage() {
        rotationTimer?.invalidate()
        rotationTimer = nil
    }
    
    @objc fileprivate func rotateCoverImageWithNSTimer(_ timer: Timer) {
        UIView.animate(withDuration: duration / 2, delay: 0, options: [.curveLinear], animations: {
            self.currentCoverImageView.transform = self.currentCoverImageView.transform.rotated(by: CGFloat(M_PI))
        }) { _ in
            UIView.animate(withDuration: self.duration / 2, delay: 0, options: [.curveLinear], animations: {
                self.currentCoverImageView.transform = self.currentCoverImageView.transform.rotated(by: CGFloat(M_PI))
            }, completion: nil)
        }
    }

}

// MARK: Status bar

extension PlayerViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}
