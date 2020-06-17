//
//  DetailViewController2.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/08.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class DetailViewController2: UIViewController {
    let key = "memoArray"
    
     // ①バーボタンアイテムの宣言
    var addBarButtonItem: UIBarButtonItem!      // +ボタン
    var editBarButtonItem: UIBarButtonItem!     // 編集ボタン
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var selectedRow:Int!
    var selectedMemo : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(memoTextView.text)
        memoTextView.text = selectedMemo
//        print(selectedMemo)
        // ②バーボタンアイテムの初期化
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addBarButtonTapped(_:)))
                // ③バーボタンアイテムの追加
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
//      addText()
     updateText()
    }
//    func addText() {
//        let text = "..."  // textView.text
//        if var memoArray = UserDefaults.standard.array(forKey: key) as? [String] {
//            // 既にデータがある場合
//            memoArray.append(text)
//            UserDefaults.standard.set(memoArray, forKey: key)
//        } else {
//            // 新規保存の場
//            var array = [String]()
//            array.append(text)
//            UserDefaults.standard.set(array, forKey: key)
//        }
//    }
    
    func updateText() {
        let inputText = selectedMemo!// DetailViewControllerで、TextViewの初期表示に使ったtext
        let editedText = memoTextView.text// textView.text
        if var memoArray = UserDefaults.standard.array(forKey: key) as? [String] {
            if let index = memoArray.firstIndex(of: inputText) {
                // `inputText`の保存位置が特定出来た場合
                memoArray[index] = editedText!
                UserDefaults.standard.set(memoArray, forKey: key)
            } else {
                // `inputText`の保存位置が特定出来なかった場合
                memoArray.append(editedText!)
                UserDefaults.standard.set(memoArray, forKey: key)
            }
        }
    }

    
    
    func showAlert(title:String){
             let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
             self.present(alert, animated: true, completion:nil)
         }
    //削除ボタンをタップした時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
           print("ボタンが押された!")
        let ud = UserDefaults.standard
        if ud.array(forKey: "memoArray") != nil{
            var saveMemoArray = ud.array(forKey: "memoArray") as![String]
            saveMemoArray.remove(at: selectedRow)
            ud.set(saveMemoArray, forKey: "memoArray" )
            ud.synchronize()
            //画面遷移
            self.navigationController?.popViewController(animated: true)
        }
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
