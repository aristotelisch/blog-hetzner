## README


CI status: [ ![Codeship Status for
aristotelisch/blog](https://www.codeship.io/projects/454c86e0-a349-0131-f685-3abfd26f95d3/status?branch=master)](https://www.codeship.io/projects/18570)

### This is a blogging application written with Ruby On Rails


* Ruby version  
  `mri 2.1.4-p265`

* System dependencies  
  `Rails 4.1.7`

* Database creation  
  `bundle exec rake db:create`

* Database initialization  
  `bundle exec rake db:seed`

* How to run the test suite  
  `bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)  
  `redis server` for session storage.

* Deployment instructions  
  Deployment is done automatically via Codeship when the tests pass on the master branch.  

  This application is deployed on a VPS running Ubuntu 12.04, Nginx and Passenger via a capistrano 2 script.
