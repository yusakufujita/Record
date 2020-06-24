//
//  TableViewController2.swift
//  Record
//
//  Created by 藤田優作 on 2020/06/08.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class TableViewController2: UITableViewController{

    
    @IBOutlet weak var memoTableView: UITableView!
    var memoArray = [String]()
    var nameArray = [String]()
    let ud = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.rowHeight = 64
        print(memoArray)
        print(nameArray)
        
  
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()      }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memoArray.count
    }

//    func AddMemoViewController
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as? memoCell else {
            fatalError()
        }
        cell.textLabel?.text = self.memoArray[indexPath.row]
            //print(nameArray)
        cell.nameLabel?.text = self.nameArray[indexPath.row]
      //print(nameArray)
            //"Name \(indexPath.row)"
        
        cell.profileImageView.backgroundColor = UIColor(
            red: CGFloat(arc4random_uniform(255)) / 255,
            green: CGFloat(arc4random_uniform(255)) / 255,
            blue: CGFloat(arc4random_uniform(255)) / 255,
            alpha: 1.0
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //destinationのクラッシュ防ぐ
        if segue.identifier == "toDetail"{
            //detailViewControllerを取得
            //as! DetailViewControllerでダウンキャストしている
            let detailViewController = segue.destination as! DetailViewController2
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
            //遷移後の内容にテキストを入れる
            detailViewController.selectedMemo = memoArray[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
            //遷移後の名前に名前を入れる
            detailViewController.selectedName = nameArray[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
            
            
        }
    }
    private func loadData() {
        loadMemo()
        loadName()
        memoTableView.reloadData()
    }
    func loadMemo(){
        if ud.array(forKey: "memoArray") != nil{
        //取得 またas!でアンラップしているのでnilじゃない時のみ
        memoArray = ud.array(forKey: "memoArray") as![String]
        }
    }
    
    func loadName() {
        if ud.array(forKey: "nameArray") != nil{
        //取得 またas!でアンラップしているのでnilじゃない時のみ
        nameArray = ud.array(forKey: "nameArray") as![String]
        }
    }

    
    

    //    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//         if editingStyle == .delete {
//            //resultArray内のindexPathのrow番目をremove（消去）する
//            memoArray.remove(at: indexPath.row)
//            //再びアプリ内に消去した配列を保存
//            ud.set(memoArray, forKey: "memoArray")
//            //tableViewを更新
//            tableView.reloadData()
//        }
//    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class memoCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
//    func nameLabel;.text = "名前"
}
