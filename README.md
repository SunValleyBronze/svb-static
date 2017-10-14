# SunValleyBronze.com Static Resources

The resources in this repository get deployed to AWS S3. 

## PDF.js

Here is what you need to know about our use of PDF.js:

### The PDF.js Code

PDF.js is a static web application maintained by Mozilla and customized for our purposes. To get an idea for what it does, visit https://mozilla.github.io/pdf.js/.

Originally, we opted to download a zipped copy of PDF.js, customize it, and then maintain it here in our GitHub repo. Currently, we have forked https://github.com/mozilla/pdf.js and have branches for each version of the library we've used. When updating, our modifications must be merged from the old version branch to the new.

The tricky part about this web application is that we have modified the HTML, the JavaScript, and added some JavaScript of our own. Here's how to identify the parts we've customized:

* The file /web/sunvalleybronze.js contains the additional variables and functions we've added to the web application.
* All other customizations have been (and must continue to be!) surrounded by comments that contain "SUNVALLEYBRONZE.COM". These files in particular have these customizations:
  * /web/viewer.js
  * /web/viewer.html
  * ...and others.
  
Unfortunately this makes upgrading from one version of PDF.js to another very time consuming. We have had to do this once to pick up a bug fix, and we had to manually and carefully move over the customizations. Now we have to carefully merge the customizations.


## Build from source

NOTE: This modified code can be generated from svb-v1.7.225 branch of the SVB pdf.js git repository: https://github.com/SunValleyBronze/pdf.js/

    git clone git@github.com:SunValleyBronze/pdf.js.git
    git checkout svb-v1.7.225
    npm install
    gulp generic

This will create a build/generic directory. You can copy the contents of that directory into build/generic in the svb-static to update the build. If your repositories are siblings, open a terminal in svb-static and run:

    cp -R ../pdf.js/build/generic/* build/generic

### How We Use PDF.js on SunValleyBronze.com

We run this PDF.js site on AWS S3 and load it in an iframe on SunValleyBronze.com. Communication between the parent frame and the iframe is necessary, and you will see code for that here in GitHub (/web/sunvalleybronze.js) and on SunValleyBronze.com (Code Blocks on the viewer pages). As of this writing the viewer pages are under "Dealer Resources" and "Public Resources" in the Squarespace Pages view.

### Customizing PDF.js

In order to make a change to this version of PDF.js, you must first modify the source files in the pdf.js project, then build using gulp generic and ensure that your changes behave correctly. Loading viewer.html from the build/generic directory in a browser allows you to perform basic tests. Once you are satisfied with your modifications, you can deploy the changes to the sunvalleybronze-viewer.com bucket on AWS S3 following the instructions below.

### Deployment

#### Setup

1. Install aws cli (note that on OSX, it will *always* be in the system python bin, even if you install using a different Python).
1. You will need your access key credentials. If you don't have them, you can make new ones from the AWS IAM console.
1. Set up aws cli by running: ```aws configure```

#### Deploy

1. Run the deployment script:
    
    ```sh deploy.sh```
    
1. Log into Amazon and verify that the new directory in the sunvalleybronze-viewer.com S3 bucket is populated correctly. Copy the directory name.
1. Log into squarespace and go to the sunvalleybronze site.
1. Go to the PAGES section.
1. Switch sunvalleybronze.com Resources to the new S3 directory:
    1. Go to Public Resources -> Resources -> more (chevron icon)
    1. Go to File Viewer -> Settings (gear icon)
    1. Click EDIT
    1. Edit viewerUrl (near the bottom) to have the new path you just created in S3. Note that this url must use the s3 domain (e.g. s3.amazonaws.com/sunvalleybronze-viewer.com) not the bucket domain (e.g. sunvalleybronze-viewer.com.s3-website-us-east-1.amazonaws.com) as only the former url supports http and https.
    1. Click Apply, then Save.
1. Repeat the previous step for Dealer Resources.
1. Verify that the new code is being loaded in the browser.

--

Questions? Contact Seth at webdevbyseth@gmail.com.
