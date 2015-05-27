#!/bin/sh
set -e
URL="https://dl.google.com/googleanalyticsservices/GoogleAnalyticsServicesiOS_3.12.zip"
 
export PRODUCT_NAME="GoogleAnalytics"
export FRAMEWORK_LOCN="${PRODUCT_NAME}.framework"
 
# Create the path to the real Headers die
mkdir -p "${FRAMEWORK_LOCN}/Versions/A/Headers"
 
# Create the required symlinks
/bin/ln -sfh A "${FRAMEWORK_LOCN}/Versions/Current"
/bin/ln -sfh Versions/Current/Headers "${FRAMEWORK_LOCN}/Headers"

curl -o GoogleAnalytics.zip $URL

unzip GoogleAnalytics.zip
 
# Copy the public headers into the framework
/bin/cp -a GoogleAnalyticsServicesiOS*/GoogleAnalytics/Library/* "${FRAMEWORK_LOCN}/Versions/A/Headers"

/bin/cp -a GoogleAnalyticsServicesiOS*/libGoogleAnalytics*.a "${FRAMEWORK_LOCN}/Versions/A/${PRODUCT_NAME}"

/bin/ln -sfh "Versions/Current/${PRODUCT_NAME}" \
             "${FRAMEWORK_LOCN}/${PRODUCT_NAME}"

rm GoogleAnalytics.zip
rm -rf GoogleAnalyticsServicesiOS*

zip -r -9 GoogleAnalytics.framework.zip GoogleAnalytics.framework
