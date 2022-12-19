//
//  ViewController.swift
//  DummyExample
//
//  Created by Allan Evans on 12/17/22.
//

import UIKit

class ViewController: UIViewController, DummyManagerDelegate {
    
    var dummyManager = DummyManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dummyManager.delegate = self
        dummyManager.fetchDummy()
    }

    func didUpdateDummy(_ dummyManager: DummyManager, dummy: DummyModel) {
        DispatchQueue.main.async {
            print(dummy.dummyId)  //Dependent on networking session
            print(dummy.dummyTitle)
            print(dummy.dummyDescription)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

