//
//  ViewController.swift
//  JacobsVoice
//
//  Created by Klemen Kastelic on 17/05/15.
//  Copyright (c) 2015 Klemen Kastelic. All rights reserved.
//

import UIKit
//import AVFoundation
import RealmSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var ButtonsCollectionView: UICollectionView!
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    @IBOutlet weak var autoButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    
    private var buttons: [Button] = []
    private var categories: [Category] = []
    var selectedCategory: String = ""
    var selectedCategoryIndex: Int = 0
    var autoSpeak = false;
    

    // ==============================================================
    //  Memory warning
    // ==============================================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ==============================================================
    //  View did load
    // ==============================================================
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup collection views
        self.setCollectionViewCellSize()
        
        // Setup categories
        self.setUpCategories()
        
        // Add device orentation change observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setCollectionViewCellSize),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil
        )
    }
    
    
    // ==============================================================
    //  Set collection view cell size
    // ==============================================================
    @objc func setCollectionViewCellSize(){
        // Set up buttons collection view
        ButtonsCollectionView.delegate = self
        ButtonsCollectionView.dataSource = self
        let spacing: CGFloat = 23.0
        let width = (ButtonsCollectionView.bounds.width - spacing)/4.0
        let height = (ButtonsCollectionView.bounds.width/4.0)/1.2
        let layout = ButtonsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        // Setup category collection view
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        let width2 = CategoryCollectionView.bounds.width
        let height2 = CategoryCollectionView.bounds.width/2
        let layout2 = CategoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout2.itemSize = CGSize(width: width2, height: height2)
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
    }
    
    
    // ==============================================================
    //  Set up Categories
    // ==============================================================
    func setUpCategories(){
        self.categories = databaseHelper.getCategories()
        
        if(self.categories.count == 0){
            databaseHelper.setup()
            setUpCategories()
        } else {
            self.setUpCategoryButtons(self.categories[0].name)
            CategoryCollectionView.reloadData()
        }
    }
    
    
    // ==============================================================
    //  Setup category buttons
    // ==============================================================
    func setUpCategoryButtons(_ categoryName:String){
        if let category = self.categories.first(where: { $0.name == categoryName }) {
            self.selectedCategoryIndex = self.categories.index(of: category) ?? 0
            self.buttons = Array(category.buttons)
            ButtonsCollectionView.reloadData()
        }
    }
    
    
    // ==============================================================
    //  Category clicked
    // ==============================================================
    @objc func categoryClicked(_ sender:UIButton) {
        print(sender.titleLabel?.text ?? "")
        
        selectedCategory = sender.titleLabel!.text!
        setUpCategoryButtons(selectedCategory)
    }
    
    
    // ==============================================================
    //  Button clicked
    // ==============================================================
    @objc func categoryButtonClicked(_ sender: UIButton){
        let text = sender.titleLabel!.text ?? ""
        
        if(autoSpeak){
            textField.text = text
            speechHelper.say(text: text)
        } else {
            appendText(text: text)
        }
    }
    
    
    // ==============================================================
    //  Button add clicked
    // ==============================================================
    @objc func buttonAddClicked(_ sender: UIButton){
        let alert = UIAlertController(title: "Button", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0]
            let text = textField.text ?? ""
            
            let btn = Button(value: ["name": text])
            self.categories[self.selectedCategoryIndex].buttons.append(btn)
            self.buttons.append(btn)
            self.ButtonsCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // ==============================================================
    //  Category add clicked
    // ==============================================================
    @objc func categoryAddClicked(_ sender: UIButton){
        let alert = UIAlertController(title: "Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = alert.textFields![0]
            let text = textField.text ?? ""
            
            self.categories.append(Category(value: ["name": text, "buttons": []]))
            self.CategoryCollectionView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // ==============================================================
    //  Clear clicked
    // ==============================================================
    @IBAction func ClearButtonClicked(sender: AnyObject) {
        textField.text = ""
    }
    
    
    // ==============================================================
    //  Speak clicked
    // ==============================================================
    @IBAction func SpeakButtonClicked(sender: AnyObject) {
        speechHelper.say(text: textField.text!)
        //textField.text = ""
    }
    
    
    // ==============================================================
    //  Auto clicked
    // ==============================================================
    @IBAction func buttonAutoClicked(sender: AnyObject) {
        if(autoSpeak){
            autoButton.setTitle("OFF", for: UIControlState.normal)
            autoSpeak = false
        } else {
            autoButton.setTitle("ON", for: UIControlState.normal)
            autoSpeak = true
        }
    }
    
    
    // ==============================================================
    //  Settings clicked
    // ==============================================================
    @IBAction func openSettingsClicked(_ sender: Any) {
        //settingsView.isHidden = false;
    }
    
    
    func appendText(text:String) {
        if(!text.isEmpty){
            textField.text = textField.text! + text + " "
        }
    }
    

    
    // ==============================================================
    //  Collection view set count
    // ==============================================================
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == ButtonsCollectionView){
            return buttons.count + 1
        } else {
            return categories.count + 1
        }
    }
    
    
    // ==============================================================
    //  Collection view set cell
    // ==============================================================
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == ButtonsCollectionView){
            // Set button cells
            if(buttons.count != indexPath.row) {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "button-cell",
                    for: indexPath
                ) as! ButtonCell
                
                cell.set(self.buttons[indexPath.row])
                cell.mainButton.addTarget(
                    self,
                    action: #selector(self.categoryButtonClicked(_:)),
                    for: .touchUpInside
                )
                
                let longPress = UILongPressGestureRecognizer(
                    target: self,
                    action: #selector(self.buttonLongPress(_:))
                )
                longPress.minimumPressDuration = 2.0
                cell.mainButton.addGestureRecognizer(longPress)
                
                return cell
            } else {
                // Add button
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "button-add-cell",
                    for: indexPath
                ) as! ButtonAddCell
                
                cell.mainButton.addTarget(
                    self,
                    action: #selector(self.buttonAddClicked(_:)),
                    for: .touchUpInside
                )
                
                return cell
            }
        } else {
            // Set category cell
            if(categories.count != indexPath.row) {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "category-cell",
                    for: indexPath
                ) as! CategoryCell
                
                cell.set(self.categories[indexPath.row])
                cell.mainButton.addTarget(
                    self,
                    action: #selector(self.categoryClicked(_:)),
                    for: .touchUpInside
                )
                
                let longPress = UILongPressGestureRecognizer(
                    target: self,
                    action: #selector(self.categoryLongPress(_:))
                )
                longPress.minimumPressDuration = 2.0
                cell.mainButton.addGestureRecognizer(longPress)
                
                return cell
            } else {
                // Add button
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "category-add-cell",
                    for: indexPath
                ) as! CategoryAddCell
                
                cell.mainButton.addTarget(
                    self,
                    action: #selector(self.categoryAddClicked(_:)),
                    for: .touchUpInside
                )
                
                return cell
            }
        }
    }
    
    
    // ==============================================================
    //  Category edit clicked
    // ==============================================================
    @objc func categoryLongPress(_ sender: UILongPressGestureRecognizer) {
        //print("LONGPRESS:", sender)
        if sender.state != .began { return }
        
        let p = sender.location(in: self.CategoryCollectionView)
        let indexPath = self.CategoryCollectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            let cell = self.CategoryCollectionView.cellForItem(at: index) as! CategoryCell
            let alert = UIAlertController(title: "Category", message: "", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = cell.category?.name ?? ""
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                let textField = alert.textFields![0]
                let text = textField.text ?? ""
                cell.category?.name = text
                cell.set(cell.category!)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            print("Could not find index path")
        }
    }
    
    
    // ==============================================================
    //  Button edit clicked
    // ==============================================================
    @objc func buttonLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .began { return }
        
        let p = sender.location(in: self.ButtonsCollectionView)
        let indexPath = self.ButtonsCollectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            let cell = self.ButtonsCollectionView.cellForItem(at: index) as! ButtonCell
            let alert = UIAlertController(title: "Button", message: "", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = cell.button?.name ?? ""
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                let textField = alert.textFields![0]
                let text = textField.text ?? ""
                cell.button?.name = text
                cell.set(cell.button!)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            print("Could not find index path")
        }
    }
    
    
}

