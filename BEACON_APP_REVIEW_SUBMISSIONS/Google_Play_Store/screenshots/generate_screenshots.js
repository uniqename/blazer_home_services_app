const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

// Screenshot configurations
const screenshots = [
    {
        name: 'feature_graphic.png',
        url: '../../../beacon-of-new-beginnings/ngo_support_app/store_assets/google_play_feature_graphic.html',
        width: 1024,
        height: 500,
        fullPage: false,
        deviceScaleFactor: 1
    },
    {
        name: 'tablet_7_screenshot_1_welcome.png',
        url: '../../../beacon-of-new-beginnings/ngo_support_app/store_assets/tablet_7_screenshot_1_welcome.html',
        width: 800,
        height: 1280,
        fullPage: false
    },
    {
        name: 'tablet_7_screenshot_2_services.png',
        url: '../../../beacon-of-new-beginnings/ngo_support_app/store_assets/tablet_7_screenshot_2_services.html',
        width: 800,
        height: 1280,
        fullPage: false
    },
    {
        name: 'tablet_10_screenshot_1_dashboard.png',
        url: '../../../beacon-of-new-beginnings/ngo_support_app/store_assets/tablet_10_screenshot_1_dashboard.html',
        width: 1024,
        height: 1366,
        fullPage: false
    },
    {
        name: 'tablet_10_screenshot_2_community.png',
        url: '../../../beacon-of-new-beginnings/ngo_support_app/store_assets/tablet_10_screenshot_2_community.html',
        width: 1024,
        height: 1366,
        fullPage: false
    }
];

async function generateScreenshots() {
    const browser = await puppeteer.launch({
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    try {
        for (const screenshot of screenshots) {
            console.log(`Generating ${screenshot.name}...`);
            
            const page = await browser.newPage();
            await page.setViewport({
                width: screenshot.width,
                height: screenshot.height,
                deviceScaleFactor: screenshot.deviceScaleFactor || 2 // High DPI for better quality, 1 for feature graphic
            });

            const htmlPath = path.resolve(__dirname, screenshot.url);
            const fileUrl = `file://${htmlPath}`;
            
            await page.goto(fileUrl, {
                waitUntil: 'networkidle0',
                timeout: 30000
            });

            // Wait for fonts and images to load
            await page.waitForTimeout(2000);

            const screenshotPath = path.join(__dirname, screenshot.name);
            await page.screenshot({
                path: screenshotPath,
                fullPage: screenshot.fullPage,
                type: 'png'
            });

            console.log(`✅ Generated ${screenshot.name}`);
            await page.close();
        }
    } catch (error) {
        console.error('Error generating screenshots:', error);
    } finally {
        await browser.close();
    }
}

// Run the screenshot generation
generateScreenshots().then(() => {
    console.log('🎉 All screenshots generated successfully!');
}).catch(error => {
    console.error('❌ Error:', error);
});