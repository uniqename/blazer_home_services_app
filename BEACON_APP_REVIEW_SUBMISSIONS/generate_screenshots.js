const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

async function generateScreenshots() {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    
    const page = await browser.newPage();
    
    // Phone screenshots (iPhone 6.5" - 1284 x 2778)
    console.log('📱 Generating iPhone screenshots...');
    await page.setViewport({
        width: 375,
        height: 812,
        deviceScaleFactor: 1
    });
    
    const phoneScreenshots = [
        {
            file: 'screenshot_templates/phone_screenshot_1_welcome.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome.png'
        },
        {
            file: 'screenshot_templates/phone_screenshot_2_resources.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_2_resources.png'
        },
        {
            file: 'screenshot_templates/phone_screenshot_3_crisis.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_3_crisis_support.png'
        },
        {
            file: 'screenshot_templates/phone_screenshot_4_community.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_4_community.png'
        },
        {
            file: 'screenshot_templates/phone_screenshot_5_safety.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_5_safety_tools.png'
        }
    ];
    
    // Generate phone screenshots
    for (const screenshot of phoneScreenshots) {
        const fullPath = path.resolve(__dirname, screenshot.file);
        console.log(`Generating ${path.basename(screenshot.output)}...`);
        
        await page.goto(`file://${fullPath}`, { 
            waitUntil: 'networkidle0',
            timeout: 30000 
        });
        
        await page.waitForTimeout(2000);
        
        await page.screenshot({ 
            path: screenshot.output,
            type: 'png',
            fullPage: false,
            clip: {
                x: 0,
                y: 0,
                width: 375,
                height: 812
            }
        });
        
        console.log(`✅ Created: ${path.basename(screenshot.output)}`);
    }
    
    // Copy phone screenshots to Google Play directory
    console.log('📱 Copying to Google Play Store directory...');
    const phoneToAndroidMap = [
        { 
            src: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome.png',
            dest: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_1.png'
        },
        { 
            src: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_2_resources.png',
            dest: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_2.png'
        },
        { 
            src: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_3_crisis_support.png',
            dest: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_3.png'
        },
        { 
            src: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_4_community.png',
            dest: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_4.png'
        },
        { 
            src: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_5_safety_tools.png',
            dest: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_5.png'
        }
    ];
    
    for (const mapping of phoneToAndroidMap) {
        fs.copyFileSync(mapping.src, mapping.dest);
        console.log(`✅ Copied: ${path.basename(mapping.dest)}`);
    }
    
    // iPad screenshots (iPad Pro 12.9" - 2048 x 2732)
    console.log('📱 Generating iPad screenshots...');
    await page.setViewport({
        width: 2048,
        height: 2732,
        deviceScaleFactor: 1
    });
    
    const ipadScreenshots = [
        {
            file: 'screenshot_templates/ipad_screenshot_1_welcome.html',
            output: '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome_ipad.png'
        }
    ];
    
    // Generate iPad screenshots
    for (const screenshot of ipadScreenshots) {
        const fullPath = path.resolve(__dirname, screenshot.file);
        console.log(`Generating ${path.basename(screenshot.output)}...`);
        
        await page.goto(`file://${fullPath}`, { 
            waitUntil: 'networkidle0',
            timeout: 30000 
        });
        
        await page.waitForTimeout(2000);
        
        await page.screenshot({ 
            path: screenshot.output,
            type: 'png',
            fullPage: false,
            clip: {
                x: 0,
                y: 0,
                width: 2048,
                height: 2732
            }
        });
        
        console.log(`✅ Created: ${path.basename(screenshot.output)}`);
    }
    
    // Copy iPad screenshot to Google Play tablet directory
    fs.copyFileSync(
        '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome_ipad.png',
        '/Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/tablet_screenshot_1.png'
    );
    console.log(`✅ Copied: tablet_screenshot_1.png`);
    
    await browser.close();
    
    console.log('\n🎉 All screenshots generated successfully!');
    console.log('📱 iPhone screenshots: 5 created');
    console.log('📱 iPad screenshots: 1 created');
    console.log('📱 Android screenshots: 5 created');
    console.log('📱 Tablet screenshots: 1 created');
    console.log('📁 Check Desktop/BEACON_APP_REVIEW_SUBMISSIONS for all files');
    console.log('🚀 Ready for app store submissions!');
}

generateScreenshots().catch(console.error);