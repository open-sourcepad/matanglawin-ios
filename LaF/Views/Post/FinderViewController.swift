import UIKit
import Alamofire
import SwiftyJSON


class FinderViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var postType = "";

    lazy var imageView: UIImageView = {
        var obj = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height));
        return obj
    }()

    lazy var changePhotoButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(10, (self.view.frame.size.height-(50*3+15)), self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Photo", forState: .Normal)
        obj.addTarget(self, action: Selector("changePhotoAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var lostButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(10, (self.view.frame.size.height-(50*2+10)), self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Lost", forState: .Normal)
        obj.addTarget(self, action: Selector("lostButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var foundButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(10, (self.view.frame.size.height-(50+5)), self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Found", forState: .Normal)
        obj.addTarget(self, action: Selector("foundButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var nameField: UITextField = {
        var obj = UITextField(frame: CGRectMake(10, 20, self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorTheme
        return obj
    }()

    lazy var descriptionField: UITextField = {
        var obj = UITextField(frame: CGRectMake(10, 80, self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorTheme
        return obj
    }()

    lazy var numberField: UITextField = {
        var obj = UITextField(frame: CGRectMake(10, 140, self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorTheme
        return obj
    }()

    lazy var findButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(10, 200, self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
        obj.setTitleColor(Constants.Colors.colorTheme, forState: .Normal)
        obj.setTitle("Search", forState: .Normal)
        obj.addTarget(self, action: Selector("findButtonAction"), forControlEvents: .TouchUpInside)
        return obj
    }()

    lazy var cancelButton: UIButton = {
        var obj = UIButton(frame: CGRectMake(10, 260, self.view.frame.size.width - 20, 50));
        obj.backgroundColor = Constants.Colors.colorThemeLightGray
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
        
        self.view.addSubview(imageView)
        self.view.addSubview(changePhotoButton)
        self.view.addSubview(lostButton)
        self.view.addSubview(foundButton)
        self.view.addSubview(overlayView)

        useCamera(self)
    }
    
    func changePhotoAction(){
//        useCameraRoll(self)
        useCamera(self)
    }
    
    func findButtonAction() {
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

                        self.appDelegate.postsViewController.post = obj
                        self.appDelegate.window?.rootViewController = self.appDelegate.postNavigation
                    }

                case .Failure(let encodingError):
                    print(encodingError)
                }
        })

    }

}