//
//  ViewController.swift
//  SQLiteExample
//
//  Created by WDP on 19/07/20.
//  Copyright © 2020 WDP. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    
    var db:DBHelper = DBHelper()
       
    var persons:[Person] = []
    var doneToolbar = UIToolbar()
    var studentID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tblView.allowsMultipleSelection = false
        addDoneButtonOnKeyboard()
         
//         db.insert(id: 1, name: "Bilal", age: 24)
//         db.insert(id: 2, name: "Bosh", age: 25)
//         db.insert(id: 3, name: "Thor", age: 23)
//         db.insert(id: 4, name: "Edward", age: 44)
//         db.insert(id: 5, name: "Ronaldo", age: 34)
//
         persons = db.read()
        
    }

    @IBAction func addAction(_ sender: Any) {
           
           let alertController = UIAlertController(title: "Add New", message: "", preferredStyle: UIAlertController.Style.alert)
           alertController.addTextField { (textField : UITextField!) -> Void in
               textField.placeholder = "Enter Name"
           }
           alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter age"
                textField.keyboardType = UIKeyboardType.phonePad
               textField.inputAccessoryView = self.doneToolbar
            }
            
           let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
               let firstTextField = alertController.textFields![0] as UITextField
               let secondTextField = alertController.textFields![1] as UITextField
               
               if firstTextField.text?.isEmpty ?? false{
                   return
               }else if secondTextField.text?.isEmpty ?? false{
                   return
               }else{
               
            //    NSInteger lastRowId = sqlite3_last_insert_rowid(yourdatabasename);

                let last_stu_id = self.persons.last?.id
                print("-----------last_stu_id-----",last_stu_id ?? 0)
                self.studentID = last_stu_id! + 1
                
                self.db.insert(id: self.studentID, name: firstTextField.text ?? "", age: Int(secondTextField.text ?? "")!)
                self.persons = self.db.read()
                self.tblView.reloadData()
               }
               
           })
           let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
               (action : UIAlertAction!) -> Void in })
    
           alertController.addAction(saveAction)
           alertController.addAction(cancelAction)
           
           self.present(alertController, animated: true, completion: nil)
       }
    func addDoneButtonOnKeyboard(){
        doneToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        
    }
    //MARK: - toolBarDone Button
    @objc func doneButtonAction(){
        self.resignFirstResponder()
      //  self.view.endEditing(true)
    }
    
    //MARK: - uitableviewDelegate datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return persons.count
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! listCell
        
        cell.lblName?.text = "Name: " + persons[indexPath.row].name + ", "

        cell.lblAge.text = "Age: " + String(persons[indexPath.row].age)
         
        return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
   // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

           if editingStyle == .delete {

               // remove the item from the data model
            let stu_id = self.persons[indexPath.row].id
            self.persons.remove(at: indexPath.row)
            self.db.deleteByID(id: stu_id)
               // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)

           } else if editingStyle == .insert {
               // Not used in our example, but if you were adding a new row, this is where you would do it.
           }
       }
}

