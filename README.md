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

This will create a build/generic directory. You can copy the contents of that directory into pdfjs-1.5.188-customized (so named for historical reasons) in this repository to update the build.

### How We Use PDF.js on SunValleyBronze.com

We run this PDF.js site on AWS S3 and load it in an iframe on SunValleyBronze.com. Communication between the parent frame and the iframe is necessary, and you will see code for that here in GitHub (/web/sunvalleybronze.js) and on SunValleyBronze.com (Code Blocks on the viewer pages). As of this writing the viewer pages are under "Dealer Resources" and "Public Resources" in the Squarespace Pages view.

### Customizing PDF.js

In order to make a change to this version of PDF.js, you must first modify the source files in pdf.js, then build using gulp generic and ensure that your changes behave correctly. Loading viewer.html from the build/generic directory in a browser allows you to perform basic tests. Once you are satisfied with your modifications, you can upload the changes to AWS S3. Be sure that all of the files are marked as public, particularly if you add a new file.

--

Questions? Contact Seth at webdevbyseth@gmail.com.
