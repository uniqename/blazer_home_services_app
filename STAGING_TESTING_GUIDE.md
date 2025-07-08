# Staging Testing Guide
## HomeLinkGH & Beacon NGO Apps

This guide provides comprehensive instructions for testing both applications in their staging environments.

---

## 🌐 Testing URLs

### HomeLinkGH Customer App
- **Staging URL**: `https://staging.homelinkgh.com`
- **Alternative**: `https://homelinkgh-staging.web.app`
- **Backend**: Supabase Staging Environment

### Beacon NGO App
- **Staging URL**: `https://staging.beaconnewbeginnings.org`
- **Alternative**: `https://beacon-staging.web.app`
- **Backend**: Local Storage (Demo Mode)

---

## 🔐 Test Credentials

### HomeLinkGH App

#### Customer Account
- **Email**: `test.customer@homelinkgh.com`
- **Password**: `TestPass123!`
- **Role**: Customer/Service Requestor

#### Provider Account
- **Email**: `test.provider@homelinkgh.com`
- **Password**: `TestPass123!`
- **Role**: Service Provider

### Beacon NGO App
- **Access**: Anonymous (No login required)
- **Mode**: Demo mode with local storage
- **Data**: Pre-populated test resources

---

## 🧪 Testing Scenarios

### HomeLinkGH Testing

#### 1. User Authentication
- [ ] Sign up with new email
- [ ] Login with test credentials
- [ ] Password reset functionality
- [ ] Profile management

#### 2. Service Discovery
- [ ] Browse available services
- [ ] Search for specific services
- [ ] Filter by location/price
- [ ] View provider profiles

#### 3. Booking Flow
- [ ] Create service request
- [ ] Select provider
- [ ] Schedule appointment
- [ ] Payment processing (test mode)

#### 4. Real-time Features
- [ ] Live chat with providers
- [ ] Push notifications
- [ ] Booking status updates
- [ ] Location tracking

#### 5. Provider Features
- [ ] Login as provider
- [ ] Manage service offerings
- [ ] Accept/decline bookings
- [ ] Update availability

### Beacon NGO Testing

#### 1. Anonymous Access
- [ ] Access app without login
- [ ] Navigate main features
- [ ] View safety information
- [ ] Access crisis resources

#### 2. Resource Directory
- [ ] Browse shelter locations
- [ ] View legal aid resources
- [ ] Access medical support info
- [ ] Find counseling services

#### 3. Emergency Features
- [ ] Quick access to emergency contacts
- [ ] Crisis hotline information
- [ ] Safety planning tools
- [ ] Emergency protocols

#### 4. Support Features
- [ ] Educational materials
- [ ] Support group information
- [ ] Recovery resources
- [ ] Trauma-informed content

---

## 📱 Test Data Available

### HomeLinkGH Test Services

#### Cleaning Services
- **Provider**: Test Cleaning Service
- **Location**: Accra Central
- **Price Range**: GHS 50-200
- **Rating**: 4.5/5
- **Services**: Regular cleaning, deep cleaning

#### Plumbing Services
- **Provider**: Test Plumbing Service
- **Location**: East Legon
- **Price Range**: GHS 100-500
- **Rating**: 4.8/5
- **Services**: Repairs, installations

#### Food Delivery
- **Provider**: Test Food Delivery
- **Location**: Osu
- **Price Range**: GHS 20-100
- **Rating**: 4.3/5
- **Services**: Food delivery, catering

### Beacon NGO Test Resources

#### Shelter Locations
- Women's Shelter - Accra Central
- Family Crisis Center - East Legon
- Emergency Housing - Osu
- Safe House Network - Tema

#### Legal Aid Services
- Legal Aid Commission
- Women's Rights Attorney
- Family Law Clinic
- Pro Bono Legal Services

#### Medical Support
- Trauma Recovery Center
- Mental Health Clinic
- Emergency Medical Care
- Specialized Counseling

---

## 🚀 Deployment Instructions

### Prerequisites
- Flutter SDK installed
- Firebase CLI installed
- Netlify CLI installed
- Git repository access

### Quick Deploy
```bash
# Navigate to project directory
cd /Users/enamegyir/Documents/Projects/blazer_home_services_app

# Run staging deployment script
./deploy_staging.sh
```

### Manual Deployment

#### HomeLinkGH
```bash
cd customer_app
flutter clean
flutter pub get
flutter build web --web-renderer html --dart-define=ENVIRONMENT=staging
firebase deploy --project homelinkgh-staging --only hosting
```

#### Beacon NGO
```bash
cd beacon-of-new-beginnings/ngo_support_app
flutter clean
flutter pub get
flutter build web --web-renderer html --dart-define=ENVIRONMENT=staging
firebase deploy --project beacon-staging --only hosting
```

---

## 🐛 Testing Checklist

### Pre-Test Setup
- [ ] Verify staging URLs are accessible
- [ ] Check test credentials work
- [ ] Confirm test data is loaded
- [ ] Verify environment banners appear

### Functional Testing
- [ ] User authentication flows
- [ ] Core app navigation
- [ ] Service/resource browsing
- [ ] Booking/interaction flows
- [ ] Real-time features
- [ ] Payment processing (test mode)

### Cross-Platform Testing
- [ ] Desktop web browser
- [ ] Mobile web browser
- [ ] iOS Safari
- [ ] Android Chrome
- [ ] Tablet devices

### Performance Testing
- [ ] Initial load time
- [ ] Navigation speed
- [ ] Database queries
- [ ] File uploads
- [ ] Real-time updates

---

## 🔧 Environment Configuration

### HomeLinkGH Staging
```javascript
{
  environment: 'staging',
  apiUrl: 'https://homelinkgh-staging.supabase.co',
  enableDebug: true,
  testMode: true,
  features: {
    authentication: true,
    realTimeUpdates: true,
    notifications: true,
    fileStorage: true,
    payments: 'test'
  }
}
```

### Beacon NGO Staging
```javascript
{
  environment: 'staging',
  mode: 'demo',
  storage: 'local',
  features: {
    anonymousAccess: true,
    resourceDirectory: true,
    emergencyContacts: true,
    safetyPlanning: true,
    offlineMode: true
  }
}
```

---

## 📞 Emergency Contacts (Real Numbers)

### Ghana Emergency Services
- **Police**: 191
- **Fire Service**: 192
- **Ambulance**: 193
- **Domestic Violence Hotline**: 0800-800-800
- **Crisis Support**: +233 50 123 4567

*Note: These are real emergency numbers. Use them only for actual emergencies.*

---

## 🛠️ Troubleshooting

### Common Issues

#### HomeLinkGH
- **Login fails**: Check if staging Supabase is running
- **Services not loading**: Verify test data is populated
- **Real-time not working**: Check WebSocket connections

#### Beacon NGO
- **App not loading**: Check local storage permissions
- **Resources missing**: Verify demo data is initialized
- **Emergency contacts not working**: Check device calling permissions

### Debug Tools
- Open browser developer tools (F12)
- Check console for errors
- Verify network requests
- Test local storage data

---

## 📊 Analytics & Monitoring

### Available Metrics
- Page views and user sessions
- Feature usage statistics
- Error rates and performance
- User flow completion rates

### Monitoring Tools
- Browser developer tools
- Firebase Analytics (HomeLinkGH)
- Local analytics (Beacon NGO)
- Custom logging endpoints

---

## 📋 Test Reports

### Test Results Template
```
Date: [DATE]
Tester: [NAME]
Environment: Staging
App: [HomeLinkGH/Beacon NGO]

Features Tested:
- [ ] Authentication
- [ ] Navigation
- [ ] Core functionality
- [ ] Performance
- [ ] Mobile responsiveness

Issues Found:
1. [Issue description]
2. [Issue description]

Overall Status: [PASS/FAIL]
```

### Bug Report Template
```
Title: [Bug Title]
App: [HomeLinkGH/Beacon NGO]
Environment: Staging
Priority: [High/Medium/Low]

Description:
[Detailed bug description]

Steps to Reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Expected Result:
[What should happen]

Actual Result:
[What actually happened]

Browser/Device:
[Browser and device information]
```

---

## 📚 Additional Resources

### Documentation
- [Flutter Web Documentation](https://flutter.dev/web)
- [Supabase Documentation](https://supabase.com/docs)
- [Firebase Hosting Guide](https://firebase.google.com/docs/hosting)
- [Netlify Deployment Guide](https://docs.netlify.com/)

### Support Contacts
- **Technical Support**: tech@homelinkgh.com
- **General Support**: support@homelinkgh.com
- **Beacon NGO Support**: support@beaconnewbeginnings.org

---

*Last Updated: 2025-01-07*
*Version: 1.0.0*