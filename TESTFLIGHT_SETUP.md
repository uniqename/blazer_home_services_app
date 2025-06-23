# TestFlight Setup Guide for Blazer Home Services App

## Prerequisites

1. **Apple Developer Account**: You need an active Apple Developer Program membership ($99/year)
2. **Xcode**: Latest version installed on macOS
3. **App Store Connect Access**: Admin/Developer access to App Store Connect

## Step 1: App Store Connect Setup

### 1.1 Create App in App Store Connect
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click "My Apps" → "+" → "New App"
3. Fill in the app information:
   - **Platform**: iOS
   - **Name**: Blazer - Home & Lifestyle Services
   - **Primary Language**: English (U.S.)
   - **Bundle ID**: Create new bundle ID (e.g., `com.blazer.homeservices`)
   - **SKU**: blazer-home-services-001 (unique identifier)

### 1.2 App Information
- **App Category**: Lifestyle
- **Secondary Category**: Food & Drink
- **Content Rights**: Check if you have the rights to use content
- **Age Rating**: Complete the age rating questionnaire

### 1.3 App Privacy
Complete the privacy questionnaire covering:
- Location data (for delivery/service tracking)
- Contact information (customer details)
- User content (reviews, ratings)
- Usage data (analytics)

## Step 2: Xcode Project Configuration

### 2.1 Open iOS Project
```bash
cd /Users/enamegyir/Documents/Projects/blazer_home_services_app/customer_app
open ios/Runner.xcworkspace
```

### 2.2 Configure Bundle Identifier
1. In Xcode, select the "Runner" project
2. Go to "Signing & Capabilities" tab
3. Set Bundle Identifier to match App Store Connect (e.g., `com.blazer.homeservices`)

### 2.3 Code Signing
1. Select your development team
2. Enable "Automatically manage signing"
3. Ensure provisioning profile is selected

### 2.4 Build Configuration
1. Set deployment target to iOS 12.0 or higher
2. Configure App Icons:
   - 1024x1024 for App Store
   - Various sizes for iOS (already included)

## Step 3: Build for TestFlight

### 3.1 Flutter Build
```bash
cd /Users/enamegyir/Documents/Projects/blazer_home_services_app/customer_app
flutter clean
flutter pub get
flutter build ios --release
```

### 3.2 Archive in Xcode
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Any iOS Device" as the destination
3. Product → Archive
4. Wait for archive to complete

### 3.3 Upload to App Store Connect
1. In Xcode Organizer, select your archive
2. Click "Distribute App"
3. Select "App Store Connect"
4. Select "Upload"
5. Follow the distribution workflow

## Step 4: TestFlight Configuration

### 4.1 Build Processing
- Wait for build to process (can take 10-60 minutes)
- You'll receive email notification when ready

### 4.2 TestFlight App Information
1. Go to App Store Connect → TestFlight
2. Select your app
3. Fill in:
   - **Test Information**: Description of what testers should focus on
   - **Beta App Description**: What the app does
   - **Feedback Email**: Where testers can send feedback
   - **Marketing URL**: Your website (optional)
   - **Privacy Policy URL**: Required for public testing

### 4.3 Export Compliance
- Select "No" for encryption if app doesn't use encryption beyond standard iOS encryption
- Or provide appropriate export compliance documentation

## Step 5: Internal Testing

### 5.1 Add Internal Testers
1. Go to TestFlight → Internal Testing
2. Add team members (up to 100 internal testers)
3. Internal testers are automatically added when build is approved

### 5.2 Enable Build for Internal Testing
1. Select your processed build
2. Add test details and submit for review
3. Internal testing starts immediately after approval

## Step 6: External Testing (Public Beta)

### 6.1 Create External Test Group
1. Go to TestFlight → External Testing
2. Create a new group (e.g., "Public Beta")
3. Add build to the group

### 6.2 Add External Testers
- **By Email**: Add individual email addresses
- **Public Link**: Create shareable TestFlight link
- **Public Link Settings**:
  - Maximum testers: up to 10,000
  - Automatic acceptance: Enable for immediate access

### 6.3 Submit for Beta App Review
- External testing requires Apple review (24-48 hours)
- Provide clear test instructions
- Explain app functionality

## Step 7: Tester Instructions

### 7.1 TestFlight App Installation
Testers need to:
1. Install TestFlight app from App Store
2. Accept invitation via email or public link
3. Install your app through TestFlight

### 7.2 Testing Focus Areas
Guide testers to focus on:
- **Multi-role onboarding**: Customer, Provider, Job Seeker, Admin flows
- **Food delivery workflow**: Ordering, tracking, restaurant dashboard
- **Service booking**: All 13 service categories
- **Earnings dashboard**: Provider payment tracking
- **Real-time features**: Order tracking, notifications
- **Cross-platform**: Test on different iOS devices

## Step 8: Feedback Collection

### 8.1 Built-in Feedback
- TestFlight provides screenshot-based feedback
- Testers can send feedback directly from the app
- Crash reports are automatically collected

### 8.2 External Feedback Channels
Set up additional channels:
- **Email**: blazer.feedback@gmail.com
- **Survey**: Google Forms or TypeForm
- **Discord/Slack**: Community feedback channels

## Step 9: Update Process

### 9.1 New Build Upload
For each update:
1. Increment version in `pubspec.yaml`
2. Run `flutter build ios --release`
3. Archive and upload new build
4. Update test notes with changelog

### 9.2 Progressive Rollout
- Start with internal testers
- Expand to small external group
- Scale to full public beta
- Monitor crash reports and feedback

## TestFlight Public Link Generation

Once approved for external testing, you'll get a public link like:
```
https://testflight.apple.com/join/ABC123XYZ
```

## Beta Testing Guidelines

### For Testers:
1. **Device Requirements**: iOS 12.0+, iPhone 6s or newer
2. **Test Duration**: 90 days per build
3. **Update Frequency**: Check for updates weekly
4. **Feedback**: Report bugs with screenshots and steps to reproduce

### For Developers:
1. **Build Frequency**: Weekly updates during active development
2. **Version Notes**: Clear changelog for each build
3. **Response Time**: Respond to feedback within 24-48 hours
4. **Crash Monitoring**: Daily review of crash reports

## Production Release Preparation

After successful beta testing:
1. Submit for App Store review
2. Prepare App Store listing with screenshots
3. Set release date and pricing
4. Monitor initial user feedback
5. Plan post-launch updates

## Troubleshooting Common Issues

### Build Upload Failures
- Check code signing certificates
- Verify bundle identifier matches App Store Connect
- Ensure no missing required architectures

### TestFlight Review Rejections
- Provide clear app functionality description
- Include demo credentials if needed
- Explain any unusual permissions or features

### Tester Installation Issues
- Verify TestFlight app is latest version
- Check iOS compatibility
- Ensure sufficient device storage

## Success Metrics

Track these metrics during beta:
- **Installation Rate**: % of invited testers who install
- **Session Duration**: How long testers use the app
- **Feature Usage**: Which features are most/least used
- **Crash Rate**: Aim for <1% crash rate
- **Feedback Quality**: Actionable vs. general feedback ratio

This comprehensive setup will enable effective beta testing of the Blazer Home Services app across all user roles and features.