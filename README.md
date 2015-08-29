# Dummy data

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://raw.githubusercontent.com/goncalossilva/dummy_data/master/LICENSE)
[![Build Status](https://travis-ci.org/goncalossilva/dummy_data.svg?branch=master)](https://travis-ci.org/goncalossilva/dummy_data)

[![Code Climate](https://codeclimate.com/github/goncalossilva/dummy_data/badges/gpa.svg)](https://codeclimate.com/github/goncalossilva/dummy_data)
[![Gem Version](https://badge.fury.io/rb/dummy_data.svg)](http://badge.fury.io/rb/dummy_data)
[![dummy_data Documentation](https://www.omniref.com/ruby/gems/dummy_data.png)](https://www.omniref.com/ruby/gems/dummy_data)

"Dummy data" is a data generator gem for your Rails 3 application.

This gem uses [dummy](http://github.com/goncalossilva/dummy) to generate dummy data for your models and
stores it in YAML files.

It also provides a rake task for you to import it to the database.

Check [dummy gem](http://github.com/goncalossilva/dummy) description for
a better notion of what exactly is dummy data.


## Installation

```
$ gem install dummy dummy_data
```


## Usage

Add the following to the Gemfile of your Rails 3 application:

```yaml
gem 'dummy_data'
```

Now you have access to the generator:
```
$ rails generate dummy:data
```

You can change the base amount of records and the growth ratio (what these mean exactly is explained latter on):
```
$ rails generate dummy:data --base-amount 5 --growth-ratio 1.5
```

Also, you can manually define the amount of records to generate for each model (or just accept the defaults):
```
$ rails generate dummy:data --manual-amounts
```
  
And you can manually set the output folder for the dummy data (which defaults to test/dummy):
```
$ rails generate dummy:data --output-folder test/awesome_dummy
```

The files will be placed under `output-folder_/data`.
    
Feel free to mix all of these options.
    
The fixtures are stored in `test/dummy/data` (by default) while
a rake file is placed in `lib/tasks/dummy_data.rake`.

It allows you to import the generated data into the database using:
```
$ RAILS_ENV="dummy" rake dummy:data:import
```

Don't forget to change `RAILS_ENV` to the appropriate environment defined in `config/databases.yml`.
Your database doesn't need to be empty.


## More information

### Smart data

"Dummy data" tells dummy to try to understand your database columns and generate data accordingly,
instead of dumping "Lorem ipsum" all over the place.

For instance, if you have a field called _company\_name_,
it will generate a company name.

If you have a field called _awesome\_postal\_code_, it will generate a valid ZIP Code.

If you have a field called _longitude_, it will generate a valid longitude, and so on.

You get the picture.

Dummy cares about associations.

It will create random associations between the automatically generated records so
you don't have to worry about that.


### Smart amounts of data

"Dummy data" is aware that the amount of records that
each model has in real world applications is different.

For this reason,
it will analyze your model associations to try to make a somewhat accurate estimation of
the expected amount of records.

To illustrate this,
consider an application with models for _Child_, _Parent_ and _GrandParent_.
If the base amount is 10,
the growth ratio is 2.0 and
the models look like the following:

```ruby
    class GrandParent < ActiveRecord::Base  
      has_many :parents
    end
    
    class Parent < ActiveRecord::Base
      belongs_to :grand_parent
      has_many :children
    end
    
    class Child < ActiveRecord::Base
        belongs_to :parent
    end`
```

The generator will create dummy data for 10 _GrandParents_, 20 _Parents_ and 40 _Children_.

Copyright (c) 2010 Gonçalo Silva
