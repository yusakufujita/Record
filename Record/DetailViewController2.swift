//
//  DetailViewController2.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/08.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class DetailViewController2: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let key = "memoArray"
    let key1 = "nameArray"
    let key2 = "saveImage"
     // ①バーボタンアイテムの宣言
    var addBarButtonItem: UIBarButtonItem!      // +ボタン
    var editBarButtonItem: UIBarButtonItem!     // 編集ボタン
    
    //画像を保存するUserDefaults
    let defaults = UserDefaults.standard
    //画像を保存する配列
    var saveImageArray: Array! = [NSData]()
    
    @IBOutlet weak var nameTextView: UITextView!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    
    @IBOutlet weak var ImageTextView: UIImageView!
    
    @IBAction func ImageView(_ sender: Any) {
        changeImage()
    }
    func changeImage() {
        //アルバムを指定
        //SourceType.camera：カメラを指定
        //SourceType.photoLibrary：アルバムを指定
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        //アルバムを立ち上げる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            //アルバム画面を開く
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //アルバム画面で写真を選択した時
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //imageにアルバムで選択した画像が格納される
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //ImageViewに表示
            self.ImageTextView.image = image
            //アルバム画面を閉じる
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func sendSaveImage() {
//        //NSData型にキャスト
//        // saveImageArray.removeAll()
//        let data = self.ImageTextView.image?.pngData() as NSData?
//        if let imageData = data {
//            saveImageArray.append(imageData)
//            defaults.set(saveImageArray, forKey: "saveImage")
//            defaults.synchronize()
//
//        }
        
        //NSData型にキャスト
        let data = self.ImageTextView.image?.pngData() as NSData?
        if let imageData = data {
            var saveImageArray = UserDefaults.standard.object(forKey: "saveImage") as? [NSData] ?? []
            //saveImageArray.insert(imageData, at: 0)
            saveImageArray.append(imageData)
            defaults.set(saveImageArray, forKey: "saveImage")
            defaults.synchronize()
        }
    }
    
    var selectedRow:Int!
    var selectedMemo : String!
    var selectedName : String!
    var selectedImage : NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.keyboardType = .namePhonePad

       // print(memoTextView.text)
        memoTextView.text = selectedMemo
        nameTextView.text = selectedName
       ImageTextView.image = UIImage(data: (selectedImage as NSData) as Data)
        
//        nameTextView.text =
//        print(selectedMemo)
        // ②バーボタンアイテムの初期化
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(addBarButtonTapped(_:)))
                // ③バーボタンアイテムの追加
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
       // print(selectedRow)

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func save(_ sender: Any) {
        updateText()
        sendSaveImage()
       
        
    }
    
    func updateText() {
        //memoTextViewのアップデート
        let inputText = selectedMemo!//DetailViewControllerで、TextViewの初期表示に使ったtext
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
        
        //nameTextViewのアップデート
        let inputNameText = selectedName!
        let editedNameText = nameTextView.text
        if var nameArray = UserDefaults.standard.array(forKey: key1) as? [String] {
            if let index = nameArray.firstIndex(of: inputNameText) {
                // `inputText`の保存位置が特定出来た場合
                nameArray[index] = editedNameText!
                UserDefaults.standard.set(nameArray, forKey: key1)
            } else {
                // `inputText`の保存位置が特定出来なかった場合
                nameArray.append(editedNameText!)
                UserDefaults.standard.set(nameArray, forKey: key1)
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
        //内容を削除
        let ud1 = UserDefaults.standard
        if ud1.array(forKey: "memoArray") != nil{
            var saveMemoArray = ud1.array(forKey: "memoArray") as![String]
            saveMemoArray.remove(at: selectedRow)
            ud1.set(saveMemoArray, forKey: "memoArray" )
            ud1.synchronize()
            //画面遷移
            self.navigationController?.popViewController(animated: true)
        }
        //名前を削除
        let ud2 = UserDefaults.standard
        if ud2.array(forKey: "nameArray") != nil{
            var saveNameArray = ud2.array(forKey: "nameArray") as![String]
            saveNameArray.remove(at: selectedRow)
            ud2.set(saveNameArray, forKey: "nameArray" )
            ud2.synchronize()
            //画面遷移
            self.navigationController?.popViewController(animated: true)
        }
        
        let ud3 = UserDefaults.standard
        if ud3.array(forKey: "saveImage") != nil{
            var saveImageArray = ud3.array(forKey: "saveImage") as![Data]
            saveImageArray.remove(at: selectedRow)
            ud3.set(saveImageArray, forKey: "saveImage" )
            ud3.synchronize()
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
