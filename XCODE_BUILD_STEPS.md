# Xcode Build Steps for TestFlight

## 🚀 Complete These Steps in Xcode

The Xcode workspace has been opened. Follow these steps to build and upload to TestFlight:

### Step 1: Configure Code Signing (CRITICAL)

1. **Select the Runner project** (top-left in Xcode)
2. **Select the Runner target** (under TARGETS)
3. **Go to "Signing & Capabilities" tab**
4. **Team**: Select your Apple Developer Team
5. **Bundle Identifier**: Change from `com.example.customerApp` to `com.blazer.homeservices` (or your preferred identifier)
6. **Check "Automatically manage signing"**

### Step 2: Update App Information

1. **Display Name**: Ensure it shows "Blazer - Home Services"
2. **Version**: Should be 1.0.0
3. **Build**: Should be 1

### Step 3: Set Build Configuration

1. **Select "Any iOS Device" from the device dropdown** (not simulator)
2. **Set scheme to "Runner"**
3. **Set build configuration to "Release"**

### Step 4: Archive the App

1. **Menu**: Product → Archive
2. **Wait for build to complete** (may take 5-10 minutes)
3. **Organizer window will open** automatically

### Step 5: Upload to App Store Connect

1. **In Organizer**: Click "Distribute App"
2. **Select**: "App Store Connect"
3. **Select**: "Upload"
4. **Distribution options**: Keep defaults checked
5. **Re-sign**: Select your team and certificates
6. **Review**: Check app information
7. **Upload**: Click "Upload" and wait

### Step 6: Create App Store Connect Entry

While upload processes, create your app in App Store Connect:

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. **My Apps** → **+** → **New App**
3. **Platform**: iOS
4. **Name**: Blazer - Home & Lifestyle Services
5. **Primary Language**: English (U.S.)
6. **Bundle ID**: Use the same as in Xcode (com.blazer.homeservices)
7. **SKU**: blazer-home-services-001

### Step 7: Configure TestFlight

Once upload completes (can take 10-60 minutes):

1. **App Store Connect** → **TestFlight**
2. **Select your app**
3. **Build will appear under "iOS Builds"**
4. **Fill out missing compliance info**:
   - Export Compliance: Select "No" (for standard encryption)
   - Test Information: "Multi-role home services platform"
   - Beta App Description: Copy from description below

### Step 8: Add Beta Testers

**Internal Testing**:
1. **TestFlight** → **Internal Testing**
2. **Add tester**: enam.a@tutamail.com
3. **Enable build for testing**

**External Testing** (for public beta):
1. **TestFlight** → **External Testing**
2. **Create group**: "Public Beta"
3. **Add build to group**
4. **Submit for Beta App Review**

---

## 📱 App Description for TestFlight

```
Blazer is a comprehensive multi-role platform for home and lifestyle services. 

🎯 ROLES SUPPORTED:
• Customers: Book services from 13+ categories
• Providers: Offer services and earn money  
• Job Seekers: Apply and get trained
• Admins: Manage the platform

🍔 DOORDASH-STYLE FEATURES:
• Real-time food delivery tracking
• Restaurant partner dashboard
• Driver earnings and analytics
• Multi-service booking system

🔥 KEY FEATURES:
• 13 service categories (Food, Cleaning, Plumbing, etc.)
• Comprehensive earnings dashboard
• Real-time order tracking
• Multi-payment options
• Admin management tools
• Job seeker onboarding and training

TESTING FOCUS:
• Test all user role flows
• Try food delivery ordering and tracking
• Check earnings dashboard functionality
• Test service booking across categories
• Verify admin panel features
```

---

## 🧪 TestFlight Invitation Process

Once your build is approved:

1. **Get the TestFlight link** from App Store Connect
2. **Share with enam.a@tutamail.com**
3. **User installs TestFlight app** from App Store
4. **User clicks invitation link**
5. **User installs Blazer app** through TestFlight

---

## 🔧 Admin User Setup

The app is already configured to recognize `enam.a@tutamail.com` as an admin user:

1. **Open Blazer app**
2. **Select "I am an Admin"**
3. **Login with**:
   - Email: enam.a@tutamail.com
   - Password: any password (demo mode)
4. **Access admin dashboard**

---

## ✅ Success Checklist

- [ ] Xcode project opened
- [ ] Code signing configured
- [ ] App archived successfully
- [ ] Uploaded to App Store Connect
- [ ] App created in App Store Connect
- [ ] TestFlight configured
- [ ] Beta tester added (enam.a@tutamail.com)
- [ ] Export compliance completed
- [ ] Build approved for testing

---

## 🆘 Troubleshooting

**Build Errors**: Check code signing and bundle ID
**Upload Fails**: Verify Apple Developer account status
**TestFlight Issues**: Ensure export compliance is filled
**Admin Access**: Use enam.a@tutamail.com in admin login

---

## 🎉 Next Steps

1. Complete Xcode build and upload
2. Configure TestFlight settings
3. Send invitation to enam.a@tutamail.com
4. Test all app features
5. Collect feedback and iterate

**The app is ready for TestFlight! 🚀**