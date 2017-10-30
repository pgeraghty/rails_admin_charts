# RailsAdminCharts

## Installation

In your `Gemfile`, add the following dependency:

    gem 'rails_admin_charts'

Run:

    $ bundle install

This will include the lazy_high_charts gem and add the assets to the pipeline. NB: remember to recompile assets if adding this to staging or production environments.

In your RailsAdmin initializer (`config/initializers/rails_admin.rb`), enable the action by adding:

```ruby
config.actions do
  all # NB: comment out this line for RailsAdmin < 0.6.0
  charts
end
```

For any model where you wish to display on or more charts (defaults to a cumulative total showing the last 100 days), add the following just under the class declaration:

```ruby
include RailsAdminCharts
```

This adds the methods `delta_records_since` and `total_records_since` to your model, alongside `graph_data` which utilises them.
The data displayed in the chart can be altered by overriding the class method `graph_data` in your model, for example in the case of a User model using single table inheritance:

```ruby
  def self.graph_data since=30.days.ago
    [[
      {
          name: 'Admin Users',
          pointInterval: point_interval = 1.day * 1000,
          pointStart: start_point = since.to_i * 1000,
          data: self.where(type: 'Admin').delta_records_since(since)
      },
      {
          name: 'Standard Users',
          pointInterval: point_interval,
          pointStart: start_point,
          data: self.where(type: nil).delta_records_since(since)
      }
    ]]
  end
```

You can set custom categories by overriding the method `xaxis`, this will be an array of array, each array for a chart

```ruby
  def self.xaxis
    [['cat a', 'cat b', 'cat c' 'cat d', 'cat e', 'cat f', 'cat g', 'cat h']]
  end
```

You can set label rotation by overriding the method `label_rotation`
It expects array of strings with values are `-45` or `-90`

```ruby
  def self.label_rotation
    ["-45"]
  end
```

This project uses MIT-LICENSE.
