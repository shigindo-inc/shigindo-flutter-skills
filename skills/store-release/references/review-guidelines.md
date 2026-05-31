# Store Review Guidelines Compliance

## Apple App Store Review Guidelines

### Content & Functionality
- [ ] App provides meaningful functionality (not a trivial wrapper)
- [ ] App description accurately represents features
- [ ] No misleading claims or fake features
- [ ] App works as described without crashes

### Privacy
- [ ] Privacy policy URL is accessible and accurate
- [ ] All data collection disclosed in App Privacy section
- [ ] `NSUserTrackingUsageDescription` if using IDFA/ATT
- [ ] Camera/microphone/location usage descriptions in Info.plist are clear and accurate
- [ ] No unnecessary data collection

### Info.plist Usage Descriptions
Required keys (if feature is used):
- `NSCameraUsageDescription` - Camera access
- `NSPhotoLibraryUsageDescription` - Photo library
- `NSMicrophoneUsageDescription` - Microphone
- `NSLocationWhenInUseUsageDescription` - Location
- `NSUserTrackingUsageDescription` - App Tracking Transparency
- `NSFaceIDUsageDescription` - Face ID

Each must have a clear, user-facing explanation of why the permission is needed.

### Design
- [ ] Follows Human Interface Guidelines (HIG) basics
- [ ] No broken links or placeholder content
- [ ] Supports current iOS versions (check minimum deployment target)
- [ ] Proper dark mode support (if applicable)

### In-App Purchases
- [ ] IAP prices match App Store Connect configuration
- [ ] Restore purchases functionality works
- [ ] Subscription terms clearly communicated

### Common Rejection Reasons
1. Crashes or bugs during review
2. Incomplete or placeholder content
3. Privacy policy missing or inaccessible
4. Usage description strings not clear enough
5. Login required but no test account provided

## Google Play Store Policies

### Content
- [ ] App content complies with content policies
- [ ] No deceptive behavior or misleading functionality
- [ ] Ads policy compliance (if ads are shown)

### Privacy & Data Safety
- [ ] Privacy policy linked in Play Console
- [ ] Data safety section completed and accurate
- [ ] Data encryption in transit
- [ ] Data deletion request mechanism (if collecting personal data)

### Technical
- [ ] Target SDK meets minimum requirement (currently API 34+)
- [ ] Permissions are minimal and justified
- [ ] Background services properly declared
- [ ] No foreground service misuse

### Store Listing
- [ ] Screenshots reflect actual app (all required form factors)
- [ ] App category correct
- [ ] Content rating questionnaire completed
- [ ] Contact information provided

### Common Rejection Reasons
1. Data safety section incomplete
2. Permissions not justified in store listing
3. Deceptive install behavior
4. Policy-violating content
5. Non-functional app features
