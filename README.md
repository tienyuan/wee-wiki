## Wee Wiki

Description
======================
This is an SaaS wiki app that incorporates Stripe. Any user can create a public wiki. If you upgrade, you can create private wikis.

Public Wikis are open to all users. Users can edit wikis, then add, edit and delete pages.

Private Wikis are open to the wiki owner and collaborators, users that the owner has added to the wiki. The owner can edit the wiki, the owner and collaborators can add, edit and delete pages.

Made with my mentor at Bloc.

Visit a working copy at [tienyuan-weewiki](http://tienyuan-weewiki.herokuapp.com/)


Setup Instructions
----------------------

Clone this repository. 

Then copy `config/application.example.yml` to `application.yml` and add values. These are the same environment settings needed in production.

Run `bundle install` to install all relevant gems.

Run `rspec/spec` to test the application.

FYI, a JS dependent feature (spec/features/upgrade_user_spec.rb) is tested using [poltergeist](http://phantomjs.org/) and [phantomjs](http://phantomjs.org/). Running this test will require additional setup. 

Run `rspec -t stripe_integration` to test stripe integration which is excluded by default.
