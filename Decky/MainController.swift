//
//  ViewController.swift
//  Decky
//
//  Created by Nick on 6/22/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    private var backingImageAnchors = [NSLayoutConstraint]()
    
    private let backingImageView: UIImageView = {
        let backingImage = UIImageView()
        backingImage.contentMode = .scaleAspectFill
        backingImage.clipsToBounds = true
        backingImage.translatesAutoresizingMaskIntoConstraints = false
        backingImage.image = UIImage(named: "nick")
        backingImage.isUserInteractionEnabled = true
        return backingImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        backingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageTap)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    }
    
    @objc fileprivate func handleImageTap() {
        let newController = Decky()
        newController.presentingController = self
        newController.controllerToPresent = TestController()
        self.present(newController, animated: false, completion: nil)
    }


}

