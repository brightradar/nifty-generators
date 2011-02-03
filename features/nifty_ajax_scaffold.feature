Feature: Nifty Ajax Scaffold Generator
  In order to manage a resource and minimize page switching
  As a rails developer
  I want to generate a model and Ajax-based controller and views for that resource

  Scenario: Generate Ajax scaffold for simple resource
    Given a new Rails app
    When I run "rails g nifty:ajax_scaffold Project name:string"
    Then I should see the following files
      | app/models/project.rb                  |
      | app/controllers/projects_controller.rb |
      | app/helpers/projects_helper.rb         |
      | app/views/projects/_form.html.erb      |
      | app/views/projects/_projects.html.erb  |
      | app/views/projects/index.html.erb      |
      | app/views/projects/create.js.erb       |
      | app/views/projects/destroy.js.erb      |
      | app/views/projects/edit.js.erb         |
      | app/views/projects/update.js.erb       |
      | db/migrate                             |
    And I should see "resources :projects" in file "config/routes.rb"
    And I should see "gem "mocha", :group => :test" in file "Gemfile"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I should successfully run "rails g nifty:ajax_scaffold Project -f"
    Then I should successfully run "rake test"

  Scenario: Generate Ajax scaffold with rspec tests
    Given a new Rails app
    When I run "rails g nifty:ajax_scaffold Project name:string --rspec"
    Then I should see the following files
      | spec/models/project_spec.rb                  |
      | spec/controllers/projects_controller_spec.rb |
    When I run "rails g nifty:ajax_scaffold Task project_id:integer"
    Then I should see the following files
      | spec/models/task_spec.rb                  |
      | spec/controllers/tasks_controller_spec.rb |
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I add "gem 'rspec-rails', '>= 2.0.0.beta.19'" to file "Gemfile"
    And I run "rails g rspec:install"
    And I replace "mock_with :rspec" with "mock_with :mocha" in file "spec/spec_helper.rb"
    Then I should successfully run "rake spec"

  Scenario: Report error when invalid model name
    Given a new Rails app
    Then I should see "Usage:" when running "rails g nifty:ajax_scaffold name:string parent_id:integer"

  Scenario: Generate Ajax scaffold for namespaced resource
    Given a new Rails app
    When I run "rails g nifty:ajax_scaffold Admin::User name:string"
    Then I should see the following files
      | app/models/user.rb                        |
      | app/controllers/admin/users_controller.rb |
      | app/helpers/admin/users_helper.rb         |
      | app/views/admin/users/index.html.erb      |
      | app/views/admin/users/show.html.erb       |
      | app/views/admin/users/new.html.erb        |
      | app/views/admin/users/edit.html.erb       |
      | db/migrate                                |
    And I should see "class User" in file "app/models/user.rb"
    And I should not see "set_table_name :" in file "app/models/user.rb"
    And I should see "namespace(:admin){ resources :users }" in file "config/routes.rb"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I should successfully run "rails g nifty:ajax_scaffold Admin::User -f"
    Then I should successfully run "rake test"

  Scenario: Generate Ajax scaffold with a namespaced model
    Given a new Rails app
    When I run "rails g nifty:ajax_scaffold Admin::User name:string --namespace_model"
    Then I should see "class Admin::User" in file "app/models/admin/user.rb"
    And I should see "set_table_name :admin_users" in file "app/models/admin/user.rb"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I should successfully run "rails g nifty:ajax_scaffold Admin::User -f --namespace_model"
    Then I should successfully run "rake test"
