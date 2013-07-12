= RailsAdminCharts

## Installation

In your `Gemfile`, add the following dependency:

    gem 'rails_admin_charts'

Run:

    $ bundle install

This will include the lazy_high_charts gem and add the assets to the pipeline.

For any model where you wish to display a chart (defaults to a cumulative total showing the last 100 days), add the following just under the class declaration:

```ruby
include RailsAdminCharts
```

This adds the methods `delta_records_since` and `total_records_since` to your model, alongside `graph_data` which utilises them.
The data displayed in the chart can be altered by overriding the class method `graph_data` in your model, for example in the case of a User model using single table inheritance:

```ruby
  def self.graph_data since=30.days.ago
    [
      {
          name: 'Admin Users',
          pointInterval: point_interval = 1.day * 1000,
          pointStart: start_point = since.to_i * 1000,
          data: self.where(user_type: 'Admin').delta_records_since(since)
      },
      {
          name: 'Standard Users',
          pointInterval: point_interval,
          pointStart: start_point,
          data: self.where(user_type: nil).delta_records_since(since)
      }
    ]
  end
```

This project uses MIT-LICENSE.