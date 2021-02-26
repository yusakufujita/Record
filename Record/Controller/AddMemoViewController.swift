//
//  AddMemoViewController.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/05.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit


class AddMemoViewController:
UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBOutlet weak var nameTextView: UITextView!
    
    var selectedRow:Int!
    var selectedMemo : String!
    //画像を保存するUserDefaults
    let defaults = UserDefaults.standard
    //画像を保存する配列
    var saveImageArray: Array! = [NSData]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        //self.textFieldInit
        nameTextView.keyboardType = .namePhonePad
        memoTextView.keyboardType = .namePhonePad
         
        //スワイプでスクロールさせたならばキーボードを下げる
            //        scrollView.keyboardDismissMode = .onDrag
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func TapImageView(_ sender: Any) {
        changeImage()
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    
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
            self.ImageView.image = image
               //アルバム画面を閉じる
            self.dismiss(animated: true, completion: nil)
           }
       }
    
    
    func sendSaveImage() {
        //NSData型にキャスト
        let data = self.ImageView.image?.pngData() as NSData?
        if let imageData = data {
            var saveImageArray = UserDefaults.standard.object(forKey: "saveImage") as? [NSData] ?? []
            saveImageArray.insert(imageData, at: 0)
            //saveImageArray.append(imageData)
            defaults.set(saveImageArray, forKey: "saveImage")
            defaults.synchronize()
        }
    }
    
//    func sendSaveImage() {
//        //NSData型にキャスト
//        let data = self.ImageView.image?.pngData() as NSData?
//        if let imageData = data {
//            saveImageArray.append(imageData)
//            defaults.set(saveImageArray, forKey: "saveImage")
//            defaults.synchronize()
//        }
//    }
//
    
 
  
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.scrollView.endEditing(true)
//    }
    
    @IBAction func tapView2(_ sender: UITapGestureRecognizer) {
        //編集中にキーボードを下げる
        scrollView.endEditing(true)
    }
 
//    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//           textField.resignFirstResponder()
//           return true
//       }
    
    
    
    @IBAction func save(_ sender: Any) {
        //画像をUserDefalutに保存
        sendSaveImage()
        //名前の保存
        let inputName = nameTextView.text
        let ud1 = UserDefaults.standard
        if ud1.array(forKey: "nameArray") != nil{
            //saveMemoArrayに取得
            var saveNameArray = ud1.array(forKey: "nameArray") as! [String]
            //テキストに何か書かれているか？
            if inputName != ""{
                //配列に追加
                //saveNameArray.append(inputName!)
                saveNameArray.insert(inputName! , at: 0)
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
                newNameArray.insert(inputName!, at: 0)
              //  newNameArray.append(inputName!)
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
               // saveMemoArray.append(inputText!)
                saveMemoArray.insert(inputText! , at: 0)
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
                newMemoArray.insert(inputText!, at: 0)
               // newMemoArray.append(inputText!)
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

