//
//  DetailViewController.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/02.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name = ""

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
