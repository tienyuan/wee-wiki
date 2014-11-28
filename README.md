## Wee Wiki

Description
----------------------
This is an SaaS app that incorporates Stripe and allows you to collaborate with others to create markdown-powered wikis.

Made with my mentor at Bloc.

Visit a working copy at [tienyuan-weewiki](http://tienyuan-weewiki.herokuapp.com/)


Features
----------------------
* You can create an account, wikis and wiki pages. If you upgrade, you'll be able to create private wikis
* Public wikis are open to all registered users.
* Private wikis are open to only added collaborators.
* Wiki owners are the only ones allowed to edit main wiki details.
* Wikis and pages support markdown
* Wikis incorporate user and SEO friendly urls

Gems include:
* haml
* figaro
* devise
* pundit
* friendly_id
* redcarpet

Setup
----------------------

Clone this repository. 

Then copy `config/application.example.yml` to `application.yml` and add values. These are the same environment settings needed in production.
```
SENDGRID_USERNAME: 
SENDGRID_PASSWORD: 

STRIPE_PUBLISHABLE_KEY:
STRIPE_SECRET_KEY:

development:
  SECRET_KEY_BASE: 
  DATABASE_USERNAME: 
  DATABASE_PASSWORD: 

test:
  SECRET_KEY_BASE: 
  DATABASE_USERNAME: 
  DATABASE_PASSWORD: 
```

Run `bundle install` to install all relevant gems.

Run `rspec/spec` to test the application.

FYI, a JS dependent feature (spec/features/upgrade_user_spec.rb) is tested using [poltergeist](http://phantomjs.org/) and [phantomjs](http://phantomjs.org/). Running this test will require additional setup. 

Run `rspec -t stripe_integration` to test stripe integration which is excluded by default.
