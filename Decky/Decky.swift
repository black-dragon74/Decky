//
//  Decky.swift
//  Decky
//
//  Created by Nick on 6/25/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class Decky: UIViewController {
    
    // The controller that is presenting the new decky controller
    // Will be used to make a snapshot
    var presentingController: UIViewController?
    
    // The controller that is being presented
    // Used to layout the frame for the view
    var controllerToPresent: UIViewController?
    
    // The imageview that will contain the screenshot of the presenting view controller
    // Smoke and mirror 1
    private let backingImageView: UIImageView = {
        let backingImage = UIImageView()
        backingImage.contentMode = .scaleAspectFill
        backingImage.clipsToBounds = true
        backingImage.translatesAutoresizingMaskIntoConstraints = false
        backingImage.isUserInteractionEnabled = true
        return backingImage
    }()
    
    // Anchors for the backing image view, we will be using this to animate the offsets
    private var backingImageAnchors = [NSLayoutConstraint]()
    
    // Status bar height
    private let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    
    // We need to set the controller to present's frame
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Now we need to check if the both vars are set
        guard let presenting = presentingController else { return }
        guard let toPresent = controllerToPresent else { return }
        
        backingImageView.image = presenting.view.takeSnapshot()
        view.addSubview(backingImageView)
        
        // Add the view anchors in the array
        backingImageAnchors.append(backingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0))
        backingImageAnchors.append(backingImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0))
        backingImageAnchors.append(backingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0))
        backingImageAnchors.append(backingImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0))
        
        // Activate the constraints
        backingImageAnchors.forEach{
            $0.isActive = true
        }
        
        // Add the controller to present's sub view
        addChild(toPresent)
        toPresent.didMove(toParent: self)
        
        view.addSubview(toPresent.view)
        toPresent.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toPresent.view.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
    }
    
    // Light status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // All we do is we animate in this area
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBackingImage()
        animateChildController()
    }
    
    //MARK:- Custom private functions
    fileprivate func animateBackingImage() {
        UIView.animate(withDuration: 0.4) {
            self.backingImageAnchors[0].constant = self.statusBarHeight
            self.backingImageAnchors[1].constant = -10
            self.backingImageAnchors[2].constant = -10
            self.backingImageAnchors[3].constant = 10
            
            self.backingImageView.layer.cornerRadius = 10
            
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func animateChildController() {
        guard let toPresent = controllerToPresent else { return }
        UIView.animate(withDuration: 0.4) {
            toPresent.view.frame = CGRect(x: 0, y: self.statusBarHeight + 20, width: self.view.frame.width, height: self.view.frame.height)
            toPresent.view.layer.cornerRadius = 10
        }
    }
    
    @objc fileprivate func handleTap() {
        guard let toPresent = controllerToPresent else { return }
        UIView.animate(withDuration: 0.4, animations: {
            self.backingImageAnchors.forEach {
                $0.constant = 0
            }
            
            self.backingImageView.layer.cornerRadius = 0
            
            toPresent.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            
            toPresent.view.layer.cornerRadius = 0
            
            self.view.layoutIfNeeded()
        }) {(_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
