//
//  AddListingTableViewController.swift
//  Urtuu
//
//  Created by Mohamed Soussi on 7/23/15.
//  Copyright (c) 2015 Niupiao. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol AddListingViewDelegate {
    func didPressCancel(addView: AddListingTableViewController)
    func didPressAdd(addView: AddListingTableViewController, newListing listing: Listing)
}

class AddListingTableViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SubcategoryPickerDelegate, PropertyPickerDelegate {
    
    var searchController: UISearchController!
    var searchBar: UISearchBar!
    var delegate: AddListingViewDelegate?
    var newListing: Listing = Listing()
    var addButton: UIBarButtonItem!
    var itemImage: UIImage? = nil{
        didSet {
            updateDisplay()
        }
    }
    var lastChosenMediaType: NSString? = nil
    var properties: [String: [String: AnyObject]]!
    var sizeRequired: Bool = false
    var volumeRequired: Bool = false
    var countRequired: Bool = false
    var currentUser: User!
    
    let itemDescriptionPlaceholder: String = "Enter item description"
    let placeholderGray: UIColor = UIColor(white: 0.78, alpha: 1)
    
    @IBOutlet weak var itemVolumeLabel: UILabel!
    @IBOutlet weak var itemSizeLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var itemBrandTF: UITextField!
    @IBOutlet weak var itemCountryTF: UITextField!
    @IBOutlet weak var itemPriceTF: UITextField!
    @IBOutlet weak var itemQuantityTF: UITextField!
    @IBOutlet weak var itemConditionTF: UITextField!
    @IBOutlet weak var itemDescriptionTV: UITextView!
    @IBOutlet weak var imageCell: UITableViewCell!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var takeAnotherImageButton: UIButton!
    @IBOutlet weak var pickCategoryCellLabel: UILabel!
    @IBOutlet weak var pickSizeCell: UITableViewCell!
    @IBOutlet weak var pickVolumeCell: UITableViewCell!
    @IBOutlet weak var pickCountCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up itemImageView
        itemImageView.clipsToBounds = true
        
        // setting up itemDescriptionTV
        itemDescriptionTV.delegate = self
        itemDescriptionTV.textColor = placeholderGray
        itemDescriptionTV.text = itemDescriptionPlaceholder
        
        // adding add and cancel buttons
        addButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "didPressAdd:")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelPressed:")
        cancelButton.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = cancelButton
        addButton.enabled = false
        
        // setting up search bar
        let searchResultsController = NewListingSearchResultsController()
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.delegate = searchResultsController
        searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.delegate = searchResultsController
        tableView.tableHeaderView = searchBar
        
        // getting properties
        properties = Constants.properties
        
        // current user
        currentUser = User.CurrentUser
        
        updateDisplay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var imageCellFrame = imageCell.frame
        imageCellFrame.size.height = self.view.frame.size.width
        imageCell.frame = imageCellFrame
        
        if pickSizeCell.frame.height == 0 {
            pickSizeCell.accessoryType = .None
            sizeRequired = false
        } else {
            pickSizeCell.accessoryType = .DisclosureIndicator
            sizeRequired = true
        }
        
        if pickVolumeCell.frame.height == 0 {
            pickVolumeCell.accessoryType = .None
            volumeRequired = false
        } else {
            pickVolumeCell.accessoryType = .DisclosureIndicator
            volumeRequired = true
        }
        
        if pickCountCell.frame.height == 0 {
            pickCountCell.accessoryType = .None
            countRequired = false
        } else {
            pickCountCell.accessoryType = .DisclosureIndicator
            countRequired = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let subCategory = newListing.itemSubcategory {
            pickCategoryCellLabel.text = subCategory
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Helper Methods
    
    func startChoosingItemImage(){
        let controller = UIAlertController(title: "Add Image", message: "Choose how you want to add listing image", preferredStyle: .ActionSheet)
        let fromCameraAction = UIAlertAction(title: "Take a picture", style: .Default, handler: {action in
            let sourceType = UIImagePickerControllerSourceType.Camera
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                self.pickMediaFromSource(sourceType)
            } else {
                let alertController = UIAlertController(title: "Error Accessing Media", message: "Unsupported Media Device", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        })
        let fromPhotoLibraryAction = UIAlertAction(title: "Choose from library", style: .Default, handler: {action in
            let sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.pickMediaFromSource(sourceType)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        controller.addAction(fromCameraAction)
        controller.addAction(fromPhotoLibraryAction)
        controller.addAction(cancelAction)
        presentViewController(controller, animated: true, completion: nil)
    }
    
    func updateDisplay(){
        if let mediaType = lastChosenMediaType {
            if mediaType == kUTTypeImage as String {
                itemImageView.image = itemImage!
                itemImageView.hidden = false
                takeAnotherImageButton.hidden = false
                addImageButton.hidden = true
            }
        } else {
            itemImageView.hidden = true
            takeAnotherImageButton.hidden = true
            addImageButton.hidden = false
        }
    }
    
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType){
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        if mediaTypes.count > 0 {
            let picker = UIImagePickerController()
            picker.mediaTypes = mediaTypes
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func heightForPropertyCell(property: String) -> CGFloat {
        if let listingCategory = newListing.itemSubcategory {
            let subcategoriesWithPropertyDict = properties[property] as! [String: [String]]
            if let propertyOptions = subcategoriesWithPropertyDict[listingCategory] {
                if propertyOptions.count >= 0 {
                    return 44
                }
            }
        }
        return 0
    }
    
    // MARK: - Action Methods
    
    func cancelPressed(addView: AddListingTableViewController){
        if let delegate = self.delegate {
            delegate.didPressCancel(self)
        }
    }
    
    func didPressAdd(sender: UIBarButtonItem){
        if newListing.itemCategory == nil {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item category", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if sizeRequired {
            if newListing.size == nil {
                let alertController = UIAlertController(title: "Missing information", message: "You're missing item size", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        if volumeRequired {
            if newListing.volume == nil {
                let alertController = UIAlertController(title: "Missing information", message: "You're missing item volume", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        if countRequired {
            if newListing.count == nil {
                let alertController = UIAlertController(title: "Missing information", message: "You're missing item count", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        if newListing.itemSubcategory == nil {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item subcategory", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if itemNameTF.text.isEmpty {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item name", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if itemBrandTF.text.isEmpty {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item brand", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if itemPriceTF.text.isEmpty {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item price", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if itemQuantityTF.text.isEmpty {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item quantity", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if itemConditionTF.text.isEmpty {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item condition", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if let image = itemImage {
            newListing.mainImage = image
        } else {
            let alertController = UIAlertController(title: "Missing information", message: "You're missing item image", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        newListing.name = itemNameTF.text
        newListing.brand = itemBrandTF.text
        newListing.countryOrigin = itemCountryTF.text
        newListing.price = (itemPriceTF.text as NSString).doubleValue
        newListing.quantity = itemQuantityTF.text.toInt()!
        newListing.condition = itemConditionTF.text
        newListing.description = itemDescriptionTV.text != itemDescriptionPlaceholder ? itemDescriptionTV.text : ""
        
        newListing.active = true
        newListing.seller = currentUser
        if let delegate = self.delegate {
            delegate.didPressAdd(self, newListing: newListing)
        }
    }
    
    @IBAction func didTapTF(sender: UITextField){
        sender.becomeFirstResponder()
    }
    
    @IBAction func didFinishEditingTF(sender: UITextField){
        sender.resignFirstResponder()
    }
    
    @IBAction func didBeginEditingTF(sender: UITextField){
        addButton.enabled = !sender.text.isEmpty
    }
    
    @IBAction func didPressTakeAnotherImage(sender: UIButton) {
        startChoosingItemImage()
    }
    
    @IBAction func didPressAddImage(sender: UIButton) {
        startChoosingItemImage()
    }
    
    // MARK: -  Text View Delegate Methods
    
    func textViewDidBeginEditing(textView: UITextView){
        if textView == itemDescriptionTV {
            if textView.text == itemDescriptionPlaceholder {
                textView.text = ""
                textView.textColor = UIColor.blackColor()
            }
            textView.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView == itemDescriptionTV {
            if textView.text == "" {
                textView.text = itemDescriptionPlaceholder
                textView.textColor = placeholderGray
            }
            textView.resignFirstResponder()
        }
    }
    
    // MARK: - Image Picker Controller Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? NSString
        if let mediaType = lastChosenMediaType {
            if mediaType == kUTTypeImage as NSString {
                itemImage = info[UIImagePickerControllerEditedImage] as? UIImage
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return self.view.frame.size.width
            }
            switch(indexPath.row){
            case 2:
                return heightForPropertyCell("size")
            case 3:
                return heightForPropertyCell("volume")
            case 4:
                return heightForPropertyCell("count")
            default:
                return 44
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 6 {
                return 44*3
            }
        }
        return 44
    }
    
    // MARK: - Navigation Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickCategory" {
            let chooseCatVC = segue.destinationViewController as! CategoryPickerViewController
            chooseCatVC.newListing = newListing
            
            chooseCatVC.addListingController = self
        } else if segue.identifier == "pickSize" {
            let pickSizeVC = segue.destinationViewController as! PropertyPickerController
            let listingSubcategory = newListing.itemSubcategory!
            let subcategoriesWithPropertyDict = properties["size"] as! [String: [String]]
            let propertyOptions = subcategoriesWithPropertyDict[listingSubcategory]
            
            pickSizeVC.propertyOptions = propertyOptions!
            pickSizeVC.propertyType = "size"
            pickSizeVC.delegate = self
            pickSizeVC.title = "Pick a Size"
        } else if segue.identifier == "pickVolume" {
            let pickVolumeVC = segue.destinationViewController as! PropertyPickerController
            let listingSubcategory = newListing.itemSubcategory!
            let subcategoriesWithPropertyDict = properties["volume"] as! [String: [String]]
            let propertyOptions = subcategoriesWithPropertyDict[listingSubcategory]
            
            pickVolumeVC.propertyOptions = propertyOptions!
            pickVolumeVC.propertyType = "volume"
            pickVolumeVC.delegate = self
            pickVolumeVC.title = "Pick a Volume"
        } else if segue.identifier == "pickCount" {
            let pickCountVC = segue.destinationViewController as! PropertyPickerController
            let listingSubcategory = newListing.itemSubcategory!
            let subcategoriesWithPropertyDict = properties["count"] as! [String:[String]]
            let propertyOptions = subcategoriesWithPropertyDict[listingSubcategory]
            
            pickCountVC.propertyOptions = propertyOptions
            pickCountVC.propertyType = "count"
            pickCountVC.delegate = self
            pickCountVC.title = "Pick a Count"
        }
    }
    
    // MARK: - Subcategory Picker Delegate Methods
    
    func didPickSubcategory(newSubcategory subCat: String) {
        newListing.itemSubcategory = subCat
        addButton.enabled = true
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - Property Picker Delegate Methods
    
    func didPickProperty(propertyPicker: PropertyPickerController, propertyType: String, property prop: String) {
        switch(propertyType){
            case "size":
            newListing.size = prop
            itemSizeLabel.text = newListing.size
            case "volume":
            newListing.volume = prop
            itemVolumeLabel.text = newListing.volume
            case "count":
            newListing.count = prop
            itemCountLabel.text = newListing.count
        default:
            println("Thanks you, Jarvis!")
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
