# ![](https://raw.github.com/aptible/straptible/master/lib/straptible/rails/templates/public.api/icon-60px.png) Lessonly Ruby Client


Ruby client for [Lesson.ly](http://lesson.ly) API.


## Installation

Add the following line to your application's Gemfile

```ruby
gem 'lessonly-ruby'
```

And then run `bundle install`.

## Usage

First, configure your client:

```ruby
require 'lessonly'

Lessonly.configure do |config|
  config.root_url = 'https://api.lesson.ly/api/v1'
  config.api_key = `LESSONLY API KEY`
  config.domain = `LESSONLY SUBDOMAIN`
end
```

This is best done in an application initializer inside `config/initializers`.

From here, you can interact with the Lessonly API resources however you wish:

### Users

```ruby
all_users = Lessonly::User.all

skylar = Lessonly::User.find(user_id)
skylar.name # "Skylar Anderson"
skylar.email # "skylar@aptible.com"

frank = Lessonly::User.create({ name: 'Frank Macreery', email: 'frank@aptible.com', role: 'learner' })
frank.name # "Frank Macreery"
```

### Groups

```ruby
all_groups = Lessonly::Group.all
developers = Lessonly::Group.find(group_id)
```

### Add a user to a group

```ruby
developers = Lessonly::Group.find(group_id)

developers.create_membership(skylar) # Add Skylar to developers group
developers.create_membership(frank) # Add Frank to developers group
```

### Courses

```ruby
all_courses = Lessonly::Course.all

course = Lessonly::Course.find(course_id)
course.create_assignment(skylar, 1.year.from_now) # Skylar assigned to course, due in 1 year

course.assignments.count # 1
course.assignments.first.user.name # "Skylar"
course.assignments.first.user.email # "skylar@aptible.com"

course.lessons.count # 1
course.lessons.first.title # "Developer Lesson"
```

### Assign a course to a user

```ruby
course = Lessonly::Course.find(course_id)
user = Lessonly::User.find(user_id)

course.create_assignment(skylar, 1.month.from_now) # User assigned to course, due in a month
```

## Contributing

1. Fork the project.
1. Commit your changes, with specs.
1. Ensure that your code passes specs (`rake spec`) and meets Aptible's Ruby style guide (`rake rubocop`).
1. Create a new pull request on GitHub.

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2014 [Aptible](https://www.aptible.com) and contributors.

[<img src="https://s.gravatar.com/avatar/9b58236204e844e3181e43e05ddb0809?s=60" style="border-radius: 50%;" alt="@sandersonet" />](https://github.com/sandersonet)