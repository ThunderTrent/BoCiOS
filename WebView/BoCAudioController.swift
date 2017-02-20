import UIKit
import AVFoundation
import CoreMedia

var songTimer = Timer()


class BoCAudioController: UIViewController  {
    
    var mp3Player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?
    
    
   @IBOutlet weak var playPauseOutlet: UIButton!
    
    @IBOutlet weak var songSlider: UISlider!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var meterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: "https://storage.googleapis.com/boc-audio/sermonsMP3/14284.mp3")
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        mp3Player = AVPlayer(playerItem: playerItem)
        
        
        
        let playerLayer=AVPlayerLayer(player: mp3Player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
       
    
    
        
        // Add playback slider
        
    
        
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        songSlider.maximumValue = Float(seconds)
        songSlider.isContinuous = true
        songSlider.tintColor = UIColor.green
  
    }
    
    func animateMeter() {
        // Animate Meter Image
        meterImage.animationImages = [
            UIImage(named: "meter1")!,
            UIImage(named: "meter2")!,
            UIImage(named: "meter3")!
        ]
        meterImage.animationDuration = 0.3
        meterImage.animationRepeatCount = 0
        meterImage.startAnimating()
    }
    

    func updateSongProgress() {

        let currentTime = mp3Player!.currentTime().seconds
        let duration = mp3Player!.currentItem!.asset.duration
        let durationTime = CMTimeGetSeconds(duration)

        
        let remainingTime = durationTime - currentTime
//        
        var currentTimeStr = ""
        var timeRemaining = ""
        if remainingTime >= 3600 {
            currentTimeStr = "\(Int(currentTime)/3600):\(Int(currentTime/60)%60):\(Int(currentTime.truncatingRemainder(dividingBy: 60)))"
            timeRemaining = "\(Int(remainingTime/3600)):\(Int(remainingTime/60)%60):\(Int(remainingTime.truncatingRemainder(dividingBy: 60)))"
        } else {
            currentTimeStr = "\(Int(currentTime/60)):\(Int(currentTime.truncatingRemainder(dividingBy: 60)))"
            timeRemaining = "-\(Int(remainingTime/60)):\(Int(remainingTime.truncatingRemainder(dividingBy: 60)))"
        }
//        
        // Show song times on labels
        currentTimeLabel.text = "\(currentTimeStr)"
        timeRemainingLabel.text = "\(timeRemaining)"
       // currentTimeLabel.text = "\(currentTime)"
       // timeRemainingLabel.text = "\(remainingTime)"
        
        // Update Song Progress Slider
        songSlider.maximumValue = Float(durationTime)
        songSlider.value = Float(currentTime)

        
    
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        let seconds : Int64 = Int64(songSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        mp3Player!.seek(to: targetTime)
        
        if mp3Player!.rate == 0
        {
            mp3Player?.play()
        }
    }
    
    @IBAction func playPauseButton(_ sender: AnyObject) {
        if mp3Player?.rate == 0
        {
            mp3Player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
           // playButton!.setTitle("Pause", for: UIControlState.normal)
            playPauseOutlet.setBackgroundImage(UIImage(named: "pauseButt"), for: UIControlState())
            
            animateMeter()
            
            
            songTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateSongProgress), userInfo: nil, repeats: true)
            
        } else {
            mp3Player!.pause()
             playPauseOutlet.setBackgroundImage(UIImage(named: "playButt"), for: UIControlState())
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
           // playButton!.setTitle("Play", for: UIControlState.normal)
           
        }
        
    }
    
    


    
}
