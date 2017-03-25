//
//  ViewController.swift
//  DrawerTest
//
//  Created by Spencer Curtis on 11/29/16.
//  Copyright © 2016 Spencer Curtis. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var drawerView: UIView!
    
    var location: CGPoint = CGPoint.zero {
        willSet {
            oldLocation = location
        }
    }
    var oldLocation: CGPoint = CGPoint.zero
    
    var locationInDrawerView = CGPoint.zero
    var velocity: CGPoint = CGPoint.zero
    var bottomStoppingPoint: CGFloat = 580
    var topStoppingPoint: CGFloat = 50
    
    var isDragging = false
    
    var currentViewPosition: ViewPosition = .top
    
    enum ViewPosition {
        case top
        case bottom
        case other
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        
        
    }
    
    func setupViews() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        panGesture.minimumNumberOfTouches = 1
        
        panGesture.delegate = self
        
        self.view.addGestureRecognizer(panGesture)
        
    }
    
    func panAction(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            break
        case .changed:
            if currentViewPosition != .other { currentViewPosition = .other }
            let location = sender.location(ofTouch: 0, in: self.view)
            self.location = CGPoint(x: location.x, y: location.y)
            
            self.locationInDrawerView = sender.location(ofTouch: 0, in: self.drawerView)
            self.velocity = sender.velocity(in: self.view)
            
            if self.drawerView.frame.contains(self.location) || isDragging {
                isDragging = true
                
                print(drawerView.frame.origin.y, self.drawerView.frame.origin.y)
                drawerView.frame.origin.y = self.location.y
            }
        case .ended:
            print(self.drawerView.frame)
            if self.velocity.y > 900 && self.drawerView.frame.contains(self.location) {
                snapToBottom()
            } else if self.velocity.y < -900 && self.drawerView.frame.contains(self.location) {
                snapToTop()
            } else if self.drawerView.frame.origin.y > bottomStoppingPoint {
                snapToBottom()
            } else if self.drawerView.frame.origin.y < topStoppingPoint {
                snapToTop()
            }
            
            isDragging = false
            self.velocity = CGPoint.zero
            
        default:
            break
        }
    }
    
    
    func snapToBottom() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.drawerView.frame.origin.y = 600
        })
        currentViewPosition = .bottom
    }
    
    func snapToTop() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.drawerView.frame.origin.y = self.topStoppingPoint + 10
        })
        currentViewPosition = .top
    }
}

