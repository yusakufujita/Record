//
//  SignUpViewController.swift
//  Record
//
//  Created by 藤田優作 on 2020/07/10.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var email: KaedeTextField!
    
    @IBOutlet weak var password: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func DoAction(_ sender: Any) {
        let email = self.email.text
        
        let password = self.password.text
        
          Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { [weak self] result, error in
             guard let self = self else { return }
             if let user = result?.user {
                 let req = user.createProfileChangeRequest()
                // req.displayName = name
                 req.commitChanges() { [weak self] error in
                     guard let self = self else { return }
                     if error == nil {
                         user.sendEmailVerification() { [weak self] error in
                             guard let self = self else { return }
                             if error == nil {
                                 // 仮登録完了画面へ遷移する処理
                             }
                             self.showErrorIfNeeded(error)
                         }
                     }
                     self.showErrorIfNeeded(error)
                 }
             }
             self.showErrorIfNeeded(error)
         }
    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
        
        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
