//
//  LoginViewController.swift
//  Record
//
//  Created by 藤田優作 on 2020/07/09.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField: KaedeTextField!
    
    @IBOutlet weak var passtextField: KaedeTextField!
    
    @IBAction func didTopSignUpButton(_ sender: Any) {
    }
    
    
    
    var changed: AuthStateDidChangeListenerHandle!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "textField & passtextField."
        passtextField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         changed = Auth.auth().addStateDidChangeListener{
                 (auth, user) in
             self.label.text = user?.email
         }
     }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(true)
          Auth.auth().removeStateDidChangeListener(changed)
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func doAction(_ sender: Any) {
        let textField = self.textField.text
        let password = self.passtextField.text
        Auth.auth().signIn(withEmail: textField ?? "", password: password ?? "" ) {
            (user, error) in
            if error != nil {
                self.label.text = error?.localizedDescription
                return
            }else {
                self.performSegue(withIdentifier: "toDetail", sender: nil)

            }
        }
    }
}
