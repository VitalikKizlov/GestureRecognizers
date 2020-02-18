//
//  ViewController.swift
//  GestureRecognizers
//
//  Created by Vitalii Kizlov on 2/18/20.
//  Copyright © 2020 Vitalii Kizlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var redView: UIView!
    
    // MARK: - Internal Properties
    
    private var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureContent()
    }
    
    private func configureContent() {
        configureGestureRecognizers()
    }
    
    private func configureGestureRecognizers() {
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(_:)))
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        
        let rotationGesture = UIRotationGestureRecognizer()
        rotationGesture.addTarget(self, action: #selector(handleRotationGesture(_:)))
        
        redView.addGestureRecognizer(pinchGesture)
        redView.addGestureRecognizer(panGesture)
        redView.addGestureRecognizer(rotationGesture)
    }
    
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))!
            gestureRecognizer.scale = 1.0
        }
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        let piece = gestureRecognizer.view!
        
        let translation = gestureRecognizer.translation(in: piece.superview)
        
        if gestureRecognizer.state == .began {
            self.initialCenter = piece.center
        }
        
        if gestureRecognizer.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        } else {
            piece.center = initialCenter
        }
    }
    
    @objc private func handleRotationGesture(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
           gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
           gestureRecognizer.rotation = 0
        }
    }


}

