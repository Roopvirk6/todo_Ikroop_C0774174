//
//  MoveToArchieveViewController.swift
//  todo_Ikroop_C0774174
//
//  Created by VirkIkroop on 2020-06-27.
//  Copyright © 2020 VirkIkroop. All rights reserved.
//

import UIKit
import CoreData

class MoveToArchieveViewController: UIViewController {
    
    
    var notebooks = [Notebook]()
    var selectednotes : [Note]?{
    didSet {
        loadFolders()
    }
    }
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    func loadFolders()
    {
        let request: NSFetchRequest<Notebook> = Notebook.fetchRequest()
        
        // predicate if you want
        let folderPredicate = NSPredicate(format: "NOT name MATCHES %@", selectednotes?[0].notebook?.name ?? "")
        request.predicate = folderPredicate
        
        do {
            notebooks = try context.fetch(request)
            print(notebooks.count)
        } catch {
            print("Error fetching data \(error.localizedDescription)")
        }
        
    }
    
    
    @IBAction func dismissVC(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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


extension MoveToArchieveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.textLabel?.text = notebooks[indexPath.row].name!
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .lightGray
        cell.tintColor = .lightText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Move to \(notebooks[indexPath.row].name!)", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Move", style: .default) { (action) in
            for note in self.selectednotes! {
                note.notebook = self.notebooks[indexPath.row]
            }
            self.performSegue(withIdentifier: "dismissMoveToVC", sender: self)
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        noAction.setValue(UIColor.orange, forKey: "titleTextColor")
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
}
