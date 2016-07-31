import UIKit
import Alamofire
import SwiftyJSON

private let kFieldHeight: CGFloat = 40.0

class FinderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var postType = "";

    lazy var imageView: UIImageView = {
        var obj = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        return obj
    }()

    lazy var changePhotoButton: MainButton = {
        var obj = MainButton(frame: CGRectMake(10, (self.view.frame.size.height-(50*3+15)), self.view.frame.size.width - 20, 50));
        obj.setTitle("Choose Photo", forState: .Normal)
        obj.addTarget(self, action: Selector("changePhotoAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var lostButton: MainButton = {
        var obj = MainButton(frame: CGRectMake(10, (self.view.frame.size.height-(50*2+10)), self.view.frame.size.width - 20, 50));
        obj.setTitle("Lost", forState: .Normal)
        obj.addTarget(self, action: Selector("lostButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var finderLabel: UILabel = {
        let obj: UILabel = UILabel(frame: CGRectMake(0,  (self.view.frame.size.height/2), self.view.frame.size.width, 100))
        obj.text = "Choose Photo and Upload"
        obj.textAlignment = NSTextAlignment.Center
        obj.backgroundColor = Constants.Colors.colorTheme
        obj.textColor = Constants.Colors.colorFontReg
        obj.font = UIFont(name: obj.font.fontName, size: 20.0)
        
        return obj
    }()

    lazy var foundButton: MainButton = {
        var obj = MainButton(frame: CGRectMake(10, (self.view.frame.size.height-(50+5)), self.view.frame.size.width - 20, 50));
        obj.setTitle("Found", forState: .Normal)
        obj.addTarget(self, action: Selector("foundButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var nameField: MainTextField = {
        var obj = MainTextField(frame: CGRectMake(10, 20, self.view.frame.size.width - 20, kFieldHeight));
        obj.isetPlaceholder("Name")
        return obj
    }()

    lazy var descriptionField: MainTextField = {
        var obj = MainTextField(frame: CGRectMake(10, self.nameField.frame.origin.y + self.nameField.frame.size.height + 10, self.nameField.frame.size.width, self.nameField.frame.size.height));
        obj.isetPlaceholder("Description")
        return obj
    }()

    lazy var numberField: MainTextField = {
        var obj = MainTextField(frame: CGRectMake(10, self.descriptionField.frame.origin.y + self.descriptionField.frame.size.height + 10, self.descriptionField.frame.size.width, self.descriptionField.frame.size.height));
        obj.isetPlaceholder("Contact Number")
        return obj
    }()

    lazy var findButton: MainButton = {
        var obj = MainButton(frame: CGRectMake(10, self.numberField.frame.origin.y + self.numberField.frame.size.height + 10, self.numberField.frame.size.width, 50));
        obj.setTitle("Search", forState: .Normal)
        obj.addTarget(self, action: Selector("findButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var cancelButton: MainButton = {
        var obj = MainButton(frame: CGRectMake(10, self.findButton.frame.origin.y + self.findButton.frame.size.height + 10, self.findButton.frame.size.width, 50));
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Cancel", forState: .Normal)
        obj.addTarget(self, action: Selector("cancelButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var overlayView: UIView = {
        var obj = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        obj.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        obj.hidden = true;
        return obj
    }()

    var alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
    
    // Create the actions
    var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
        UIAlertAction in
        NSLog("OK Pressed")
    }
    var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
        UIAlertAction in
        NSLog("Cancel Pressed")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Colors.colorTheme
        self.navigationController?.navigationBarHidden = true
        self.title = "Post"

        overlayView.addSubview(nameField)
        overlayView.addSubview(descriptionField)
        overlayView.addSubview(numberField)
        overlayView.addSubview(findButton)
        overlayView.addSubview(cancelButton)

        self.view.addSubview(finderLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(changePhotoButton)
        self.view.addSubview(lostButton)
        self.view.addSubview(foundButton)
        self.view.addSubview(overlayView)

        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        useCamera(self)
    }
    
    func changePhotoAction(){
//        useCameraRoll(self)
        useCamera(self)
    }
    
    func findButtonAction() {
        self.findButton.enabled = false
        self.findButton.setTitle("Wait...", forState: .Normal)
        savePost()
    }

    func lostButtonAction() {
        postType = "LOST";
        overlayView.hidden = false;
    }

    func foundButtonAction() {
        postType = "FOUND";
        overlayView.hidden = false;
    }

    func cancelButtonAction() {
        overlayView.hidden = true;
    }

    func useCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
        }else {
            useCameraRoll(self)
        }
    }

    func useCameraRoll(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
        }
    }

    /* delegates */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        
        imageView.image = image
        
        UIImageWriteToSavedPhotosAlbum(image, self,
            "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
    func savePost() {
        let params = [
            "listing[name]":  nameField.text!,
            "listing[description]":  descriptionField.text!,
            "listing[contact]":  numberField.text!,
            "listing[mytype]":  postType,
        ]
        print(UserDM.getActiveUser().authenticationToken!)
        Alamofire.upload(.POST, Constants.API.create_post, headers:
            ["AuthToken": UserDM.getActiveUser().authenticationToken!], multipartFormData: {
            multipartFormData in
            if  let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.6) {
                multipartFormData.appendBodyPart(data: imageData, name: "listing[image]", fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in params {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):

                    upload.responseJSON { response in
                        if (response.result.isSuccess) {
                            let json = JSON(response.result.value!)
                            let obj: PostDM = PostDM();
                            obj.postId = json["id"].intValue
                            obj.name = json["name"].stringValue
                            obj.desc = json["description"].stringValue
                            obj.contact = json["contact"].stringValue
                            obj.lambdal_id = json["lambdal_id"].stringValue
                            obj.nickname = json["nickname"].stringValue
                            obj.birthday = json["birthday"].stringValue
                            obj.age = json["age"].intValue
                            obj.created_at = json["created_at"].stringValue
                            obj.updated_at = json["updated_at"].stringValue
                            obj.mytype = json["mytype"].stringValue
                            obj.image_url = json["image_url"].stringValue
                            obj.match = json["match"].stringValue
                            
                            self.appDelegate.postsViewController.post = obj
                            self.appDelegate.window?.rootViewController = self.appDelegate.postNavigation
                        }else{
                            self.presentViewController(self.alertController, animated: true, completion: nil)
                        }

                        self.findButton.enabled = true
                        self.findButton.setTitle("Search", forState: .Normal)
                        print(response.result.isSuccess)
                    }

                case .Failure(let encodingError):
                    print(encodingError)
                    self.findButton.enabled = true
                    self.findButton.setTitle("Search", forState: .Normal)
                }

        })

    }

}