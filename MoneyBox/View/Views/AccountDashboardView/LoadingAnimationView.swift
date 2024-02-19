//
//  LoadingAnimationView.swift
//  MoneyBox
//
//  Created by hanif hussain on 19/02/2024.
//

import UIKit
import Lottie

class LoadingAnimationView: UIView {
    // create a lottie animation view to add a little animation to let the user know we are grabbing their account info
    var animationView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAnimation() {
        // 2. Start LottieAnimationView with animation name (without extension)
        animationView = .init(name: "loadingHamster")
        animationView!.translatesAutoresizingMaskIntoConstraints = false
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        
        self.addSubview(animationView!)
        
        NSLayoutConstraint.activate([
            animationView!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            animationView!.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        animationView!.play()
    }
}
