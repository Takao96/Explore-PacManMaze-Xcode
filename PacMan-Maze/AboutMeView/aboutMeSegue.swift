//
//  aboutMeSegue.swift
//  AleappAR
//
//  Created by Ferdinando Piedepalumbo on 12/11/2018.
//  Copyright © 2018 Ferdinando Piedepalumbo. All rights reserved.
//

import UIKit

class aboutMeSegue: UIStoryboardSegue {

    override func perform() {
        scale()
    }
    
    func scale(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
            })
    }
}

class UnwindScaleSegue:UIStoryboardSegue{
    override func perform() {
        scale()
    }
    
    func scale(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        }, completion: { success in
           fromViewController.dismiss(animated: false, completion: nil)
        })

    }
    
}
