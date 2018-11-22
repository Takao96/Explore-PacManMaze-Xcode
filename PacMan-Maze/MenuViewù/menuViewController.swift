//
//  menuViewController.swift
//  AleappAR
//
//  Created by Ferdinando Piedepalumbo on 12/11/2018.
//  Copyright © 2018 Ferdinando Piedepalumbo. All rights reserved.
//

import UIKit

class menuViewController: UIViewController {

    @IBOutlet weak var GifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GifView.loadGif(name: "pacman")
    }
    
    @IBAction func prepareForUnwind(for segue: UIStoryboardSegue) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
