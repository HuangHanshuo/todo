//
//  ViewController.swift
//  Todo
//
//  Created by Arthur on 6/6/15.
//  Copyright (c) 2015 Arthur. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todos = [NSManagedObject]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let managedContext = getmanagedContext()
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Todo")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            todos = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let todo = todos.removeAtIndex(indexPath.row)
            let managedContext = getmanagedContext()
            managedContext.deleteObject(todo)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell!
        
        let todo = todos[indexPath.row]
        var imageView1 = cell.viewWithTag(100) as! UIImageView!
        var titleLabel1 = cell.viewWithTag(101) as! UILabel!
        var dateLabel1 = cell.viewWithTag(102) as! UILabel!
        
        titleLabel1.text = todo.valueForKey("title") as? String
        
        return cell
    }
    
    @IBAction func addTodo(sender: AnyObject) {
        //1
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        let managedContext = appDelegate.managedObjectContext!
        let managedContext = getmanagedContext()
        //2
        let entity =  NSEntityDescription.entityForName("Todo",
            inManagedObjectContext:
            managedContext)
        
        let todo = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        todo.setValue("1", forKey: "id")
        todo.setValue("title 1", forKey: "title")
        todo.setValue("type 1", forKey: "type")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        todos.append(todo)
        self.tableView.reloadData()
    }
    
    func getmanagedContext() -> NSManagedObjectContext {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        return managedContext
    }
}

