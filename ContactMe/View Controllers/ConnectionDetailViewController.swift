//
//  ConnectionDetailViewController.swift
//  ContactMe
//
//  Created by Javier Portaluppi on 23/12/2019.
//  Copyright © 2019 IPL-Master. All rights reserved.
//

import UIKit
import MapKit

class ConnectionDetailViewController: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var genderUIImage: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var emailTextView: UITextView!
    
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberTextView: UITextView!
    @IBOutlet weak var universityLabel: UILabel!
    
    @IBOutlet weak var studyingLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    
    @IBOutlet weak var interestsStackView: UIStackView!
    
    @IBOutlet weak var mondayFreeSchedule: UILabel!
    
    @IBOutlet weak var tuesdayFreeSchedule: UILabel!
    @IBOutlet weak var wednesdayFreeSchedule: UILabel!
    
    @IBOutlet weak var thursdayFreeSchedule: UILabel!
    
    @IBOutlet weak var fridayFreeSchedule: UILabel!
    
    @IBOutlet weak var saturdayFreeSchedule: UILabel!
    
    @IBOutlet weak var sundayFreeSchedule: UILabel!
    @IBOutlet weak var meetingLocation: UILabel!
    
    @IBOutlet weak var meetingDateTime: UILabel!
    
    @IBOutlet weak var freeTimePlaceMap: MKMapView!
    
    @IBOutlet weak var interestsView: UIView!
    var profileId: Int64 = 0
    
    var connectionProfile = Profile()
    var myProfile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getConnectionProfile(profileId: self.profileId)
        
        getMyProfile()
        
        setProfileOutlets()
    }
    
    func getMyProfile(){
        if let currentUser = UserService.getCurrentUserSession() {
            if let currentUserProfile = try? ProfileDataHelper.find(idobj: currentUser.profileId!){
                self.myProfile = currentUserProfile
                
            }
        }
    }
    
    func isUserFreeAtCurrentTime() -> Bool {
        
        //get current day
        let calendar = Calendar.current
        let currentDate = Date()
        let dayOfWeek = calendar.component(.weekday, from: currentDate)
        
        
        switch dayOfWeek {
        case 1: //sunday
            return isFreeOnXDay(startTime: connectionProfile.sundayFreeStartTime ?? "", endTime: connectionProfile.sundayFreeEndTime ?? "")
        case 2: //monday
            return isFreeOnXDay(startTime: connectionProfile.mondayFreeStartTime ?? "", endTime: connectionProfile.mondayFreeEndTime ?? "")
        case 3: //tuesday
            return isFreeOnXDay(startTime: connectionProfile.tuesdayFreeStartTime ?? "", endTime: connectionProfile.tuesdayFreeEndTime ?? "")
        case 4: //wednesday
            return isFreeOnXDay(startTime: connectionProfile.wednesdayFreeStartTime ?? "", endTime: connectionProfile.wednesdayFreeEndTime ?? "")
        case 5: //thursday
            return isFreeOnXDay(startTime: connectionProfile.thursdayFreeStartTime ?? "", endTime: connectionProfile.thursdayFreeEndTime ?? "")
        case 6: //friday
            return isFreeOnXDay(startTime: connectionProfile.fridayFreeStartTime ?? "", endTime: connectionProfile.fridayFreeEndTime ?? "")
        case 7: //saturday
            return isFreeOnXDay(startTime: connectionProfile.saturdayFreeStartTime ?? "", endTime: connectionProfile.saturdayFreeEndTime ?? "")
        default:
            return false
        }
        
        
    }
    
    func isFreeOnXDay(startTime: String, endTime: String) -> Bool {
        if (startTime.isEmpty || endTime.isEmpty){
            return false
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        //This is following the format HH:mm
        guard let startHour = Int(String(startTime[startTime.startIndex]) + String(startTime[startTime.index(startTime.startIndex, offsetBy: 1)])) else { return false }
        
        guard let startMinute = Int(String(startTime[startTime.index(startTime.startIndex, offsetBy: 3)]) + String(startTime[startTime.index(startTime.startIndex, offsetBy: 4)])) else { return false }
        
        guard let endHour = Int(String(endTime[endTime.startIndex]) + String(endTime[endTime.index(endTime.startIndex, offsetBy: 1)])) else { return false }
        
        guard let endMinute = Int(String(startTime[endTime.index(endTime.startIndex, offsetBy: 3)]) + String(endTime[endTime.index(endTime.startIndex, offsetBy: 4)])) else { return false }
        
        
        let startCalendar = calendar.date(
            bySettingHour: startHour,
            minute: startMinute,
            second: 0,
            of: currentDate)!
        
        let endCalendar = calendar.date(
            bySettingHour: endHour,
            minute: endMinute,
            second: 0,
            of: currentDate)!
        
        
        if currentDate >= startCalendar &&
            currentDate <= endCalendar
        {
            return true
        }
        
        return false
    }
    
    
    func getConnectionProfile(profileId: Int64) {
        if let currentProfile = try? ProfileDataHelper.find(idobj: profileId){
            connectionProfile = currentProfile
            
            connectionProfile.visit+=1
            try! ProfileDataHelper.update(item: connectionProfile)
        }
    }
    
    func setProfileOutlets(){
        
        avatarImageView.makeRounded()
        avatarImageView.setUIImageView(imgUrl: connectionProfile.avatar)
        
        if (connectionProfile.gender == "F"){
            genderUIImage.image = UIImage(named: "icon-gender-female")
        }else{
            genderUIImage.image = UIImage(named: "icon-gender-male")
        }
        
        emailTextView.text = connectionProfile.email
        emailTextView.centerVertically()
        
        if(!(connectionProfile.dateOfBirth ?? "").isEmpty){
            ageLabel.text = calculateAge()
        }
        fullnameLabel.text = connectionProfile.fullName()
        
        phoneNumberTextView.text = connectionProfile.phone
        phoneNumberTextView.centerVertically()
        
        universityLabel.text = connectionProfile.universityName
        studyingLabel.text = connectionProfile.carieer
        jobLabel.text = connectionProfile.job
        //interestsListLabel.text = connectionProfile.insterest
        
        showInterests()
        
        if(isUserFreeAtCurrentTime()){
            currentStatusLabel.text = "Free Now"
            currentStatusLabel.textColor = UIColor.systemGreen
            
        }else{
            currentStatusLabel.text = "Busy Now"
            currentStatusLabel.textColor = UIColor.systemRed
            
        }
        
        if(!(connectionProfile.mondayFreeStartTime ?? "").isEmpty && !(connectionProfile.mondayFreeEndTime ?? "").isEmpty ){
            mondayFreeSchedule.text = "From: \(connectionProfile.mondayFreeStartTime ?? "") To: \(connectionProfile.mondayFreeEndTime ?? "")"
            mondayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            mondayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.tuesdayFreeStartTime ?? "").isEmpty && !(connectionProfile.tuesdayFreeEndTime ?? "").isEmpty ){
            tuesdayFreeSchedule.text = "From: \(connectionProfile.tuesdayFreeStartTime ?? "") To: \(connectionProfile.tuesdayFreeEndTime ?? "")"
            tuesdayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            tuesdayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.wednesdayFreeStartTime ?? "").isEmpty && !(connectionProfile.wednesdayFreeEndTime ?? "").isEmpty ){
            wednesdayFreeSchedule.text = "From: \(connectionProfile.wednesdayFreeStartTime ?? "") To: \(connectionProfile.wednesdayFreeEndTime ?? "")"
            wednesdayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            wednesdayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.thursdayFreeStartTime ?? "").isEmpty && !(connectionProfile.thursdayFreeEndTime ?? "").isEmpty ){
            thursdayFreeSchedule.text = "From: \(connectionProfile.thursdayFreeStartTime ?? "") To: \(connectionProfile.thursdayFreeEndTime ?? "")"
            thursdayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            thursdayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.fridayFreeStartTime ?? "").isEmpty && !(connectionProfile.fridayFreeEndTime ?? "").isEmpty ){
            fridayFreeSchedule.text = "From: \(connectionProfile.fridayFreeStartTime ?? "") To: \(connectionProfile.fridayFreeEndTime ?? "")"
            fridayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            fridayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.saturdayFreeStartTime ?? "").isEmpty && !(connectionProfile.saturdayFreeEndTime ?? "").isEmpty ){
            saturdayFreeSchedule.text = "From: \(connectionProfile.saturdayFreeStartTime ?? "") To: \(connectionProfile.saturdayFreeEndTime ?? "")"
            saturdayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            saturdayFreeSchedule.text = "Busy"
        }
        
        if(!(connectionProfile.sundayFreeStartTime ?? "").isEmpty && !(connectionProfile.sundayFreeEndTime ?? "").isEmpty ){
            sundayFreeSchedule.text = "From: \(connectionProfile.sundayFreeStartTime ?? "") To: \(connectionProfile.sundayFreeEndTime ?? "")"
            sundayFreeSchedule.textColor = UIColor.systemGreen
        }else{
            sundayFreeSchedule.text = "Busy"
        }
        
        meetingLocation.text = connectionProfile.connectionLocationName
        
        // ask for the full relative date
        if #available(iOS 13.0, *), connectionProfile.connectionDateTime != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let connectionDateTime = dateFormatter.date(from: connectionProfile.connectionDateTime ?? "")!
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            let relativeDate = formatter.localizedString(for: connectionDateTime, relativeTo: Date())
            meetingDateTime.text = relativeDate
        } else {
            // Fallback on earlier versions
            meetingDateTime.text = connectionProfile.connectionDateTime
        }
        
        setMap()
        
    }
    
    private func showInterests(){
        //get matches interests
        
        if let interests = connectionProfile.insterestArray {
            for interest in interests {
                addInterestLabel(labelText: interest)
            }
        }
    }
    
    private func addInterestLabel(labelText: String){
        //Get if interest matches
        var interestIsMatching=false
        if (myProfile.insterestArray?.contains(labelText) == true){
            interestIsMatching=true
        }
        
        //Create label dynamically
        var label = UILabel(frame: .zero)
        
        if(interestIsMatching){
            label = BadgeLabel(frame: .zero)
        }
        
        //Add text
        label.text = labelText
        
        //Set dimension accoriding to text length
        label.sizeToFit()
        
        //Add in container
        let uiContainer = UIView()
        uiContainer.addSubview(label)
        
        //Dinamically adding constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: label.intrinsicContentSize.width).isActive = true
        
        if(interestIsMatching){
            uiContainer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        
        //Add UIView with the subview UILabel to the Stack View
        interestsStackView.addArrangedSubview(uiContainer)
    }
    
    private func setMap(){
        
        if let latitude=connectionProfile.freeTimeLatitude,
            let longitude=connectionProfile.freeTimeLongitude {
            
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            let regionRadius: CLLocationDistance = 1500
            
            let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            freeTimePlaceMap.setRegion(coordinateRegion, animated: true)
            
            
            let freeTimePLaceAnnotation = MKPointAnnotation()
            freeTimePLaceAnnotation.title = connectionProfile.freeTimePlaceName
            freeTimePLaceAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            freeTimePlaceMap.addAnnotation(freeTimePLaceAnnotation)
            
            
        }
        
        
        
        
        
    }
    
    private func calculateAge() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateOfBirth = dateFormatter.date(from: connectionProfile.dateOfBirth ?? "")!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: now)
        
        let age = ageComponents.year
        return "\(String(age ?? 0)) years old"
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





