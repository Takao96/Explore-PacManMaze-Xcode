//
//  firstViewController.swift
//  AleappAR
//
//  Created by Ferdinando Piedepalumbo on 12/11/2018.
//  Copyright © 2018 Ferdinando Piedepalumbo. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func prepareForUnwind(for segue: UIStoryboardSegue) {
        
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        let segue = UnwindScaleSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
