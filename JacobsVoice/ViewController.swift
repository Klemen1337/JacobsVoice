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
    var speechHelper = SpeechHelper()
    var databaseHelper = DatabaseHelper()
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
        
        //let realm = try! Realm()
        //try! realm.write() {
        //    let category = realm.create(Category.self, value: ["name": "Category 1"])
        //    realm.create(Button.self, value: ["name": "This is a test", "category": category])
        //}
        //
        //let tanDogs = realm.objects(Button.self)
        //print(tanDogs)

        // Setup collection views
        self.setCollectionViewCellSize()
        
        // Setup categories
        self.setUpCategories()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setCollectionViewCellSize), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

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
        self.categories = [
            Category(value: [
                "name": "People",
                "buttons": [
                    Button(value: ["name": "Klemen", "color": "CCCCCC" ]),
                    Button(value: ["name": "Barbara", "color": "CCCCCC" ]),
                    Button(value: ["name": "Jacob", "color": "CCCCCC" ])
                ]
            ]),
            Category(value: [
                "name": "Places",
                "buttons": [
                    Button(value: ["name": "Home", "color": "CCCCCC" ]),
                    Button(value: ["name": "Store", "color": "CCCCCC" ]),
                    Button(value: ["name": "School", "color": "CCCCCC" ]),
                    Button(value: ["name": "Gym", "color": "CCCCCC" ])
                ]
            ])
        ]
        
        self.setUpCategoryButtons(self.categories[0].name)
        CategoryCollectionView.reloadData()
    }
    
    
    // ==============================================================
    //  Category buttons
    // ==============================================================
    func setUpCategoryButtons(_ categoryName:String){
        if let category = self.categories.first(where: { $0.name == categoryName }) {
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
    @objc func categoryButtonClicked(_ sender:UIButton){
        let text = sender.titleLabel!.text ?? ""
        
        if(autoSpeak){
            textField.text = text
            speechHelper.say(text: text)
        } else {
            appendText(text: text)
        }
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
            return buttons.count
        } else {
            return categories.count
        }
    }
    
    
    // ==============================================================
    //  Collection view set cell
    // ==============================================================
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == ButtonsCollectionView){
            // Set button cell
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
            
            return cell
        } else {
            // Set category cell
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
            
            return cell
        }
        
    }
}

