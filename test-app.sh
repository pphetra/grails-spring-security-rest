#!/bin/sh

./grailsw test-app \
  && cd test/apps \
  && for app in `ls .`; do
     cd $app \
        && rm -f grails-app/conf/Config.groovy \
        && for config in `ls grails-app/conf/Config*.groovy`; do
           cp $config grails-app/conf/Config.groovy \
           && rm -rf target \
           && ../../../grailsw test-app --echoOut \
           && rm grails-app/conf/Config.groovy
           if [ $? -ne 0 ]; then
              exit $?
           fi
           done
     done \
  && cd ../../../