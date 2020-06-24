//
//  AddMemoViewController.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/05.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class AddMemoViewController: UIViewController {
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBOutlet weak var nameTextView: UITextView!
    var selectedRow:Int!
    var selectedMemo : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memoTextView.text = selectedMemo
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: Any) {
        //名前の保存
        let inputName = nameTextView.text
        let ud1 = UserDefaults.standard
        if ud1.array(forKey: "nameArray") != nil{
            //saveMemoArrayに取得
            var saveNameArray = ud1.array(forKey: "nameArray") as! [String]
            //テキストに何か書かれているか？
            if inputName != ""{
                //配列に追加
                saveNameArray.append(inputName!)
                ud1.set(saveNameArray, forKey: "nameArray")
            }else{
                showAlert(title: "何も入力されていません")
            }
        }else{
            //最初、何も書かれていない場合
            var newNameArray = [String]()
            //nilを強制アンラップはエラーが出るから
            if inputName != ""{
                //inputtextはoptional型だから強制アンラップ
                newNameArray.append(inputName!)
                ud1.set(newNameArray, forKey: "nameArray")
            }else{
                showAlert(title: "何も入力されていません")
            }
        }
   
        //内容の保存
        let inputText = memoTextView.text
        let ud2 = UserDefaults.standard
        if ud2.array(forKey: "memoArray") != nil{
            //saveMemoArrayに取得
            var saveMemoArray = ud2.array(forKey: "memoArray") as! [String]
                //テキストに何か書かれているか？
            if inputText != ""{
                //配列に追加
                saveMemoArray.append(inputText!)
                ud2.set(saveMemoArray, forKey: "memoArray")
            }else{
                showAlert(title: "何も入力されていません")
            }
        }else{
            //最初、何も書かれていない場合
            var newMemoArray = [String]()
            //nilを強制アンラップはエラーが出るから
            if inputText != ""{
            //inputtextはoptional型だから強制アンラップ
                newMemoArray.append(inputText!)
                ud2.set(newMemoArray, forKey: "memoArray")
            }else{
                showAlert(title: "何も入力されていません")
            }
        }
              showAlert(title: "保存完了")
              ud2.synchronize()
    }
    
    func showAlert(title:String){
           let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion:nil)
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
