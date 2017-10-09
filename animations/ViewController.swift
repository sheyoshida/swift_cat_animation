//
//  ViewController.swift
//  animations
//
//  Created by Shena Yoshida on 6/17/17.
//  Copyright © 2017 Shena Yoshida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var eyesImageView: UIImageView!
    @IBOutlet weak var eyesToBodyConstraint: NSLayoutConstraint!
    @IBOutlet weak var popUpCatImageView: UIImageView!
    
    var images = [UIImage(named: "popUpCat1")]
    var animatedImage: UIImage!
    
    // Mark: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catImageView.isHidden = true
        eyesImageView.isHidden = true
    }
    
    // Mark: - Animation
    
    func getPopUpImages() {
        var catImage: UIImage!
        for i in 2...62 {
            let fileName = "popUpCat" + "\(String(i))"
            catImage = UIImage(named: fileName)
            images.append(catImage)
        }
    }
    
    func getPopDownImages() {
        var catImage: UIImage!
        for i in (1...62).reversed() {
            let fileName = "popUpCat" + "\(String(i))"
            catImage = UIImage(named: fileName)
            images.append(catImage)
        }
    }
    
    func animatedImageWithImagesUp() {
        getPopUpImages()
        let animationDuration = 1.0
        animatedImage = UIImage.animatedImage(with: images as! [UIImage], duration: animationDuration)
        popUpCatImageView.image = animatedImage
        
        // set timer to end loop
        Timer.scheduledTimer(timeInterval: animationDuration, target: self, selector: #selector(ViewController.animationDidStop(timer:)), userInfo: nil, repeats: false)
    }
    
    @objc func animationDidStop(timer: Timer!) {
        timer.invalidate()
        
        popUpCatImageView.isHidden = true
        catImageView.isHidden = false
        eyesImageView.isHidden = false
        
        animateImageTransition() // animate eyes
        images.removeAll()
        
    }
    
    func animateImageTransition() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       options: [.curveEaseIn],
                       animations: {
                        self.eyesToBodyConstraint.constant = -8 // move to left
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        self.animateImageTransitionToRight()
        })
    }
    
    func animateImageTransitionToRight() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseIn],
                       animations: {
                        self.eyesToBodyConstraint.constant = +8 // move to right
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        self.animateImageTransitionToCenter()
        })
    }
    
    func animateImageTransitionToCenter() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseIn],
                       animations: {
                        self.eyesToBodyConstraint.constant = 0 // move to center
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        // animation complete, do more stuff?
        })
    }
    
    // Mark: - Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        animatedImageWithImagesUp()
    }
    
}

