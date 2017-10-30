require 'lazy_high_charts/engine'
require 'rails_admin_charts/engine'

module RailsAdminCharts
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def total_records_since(since = 30.days.ago)
      date_created_at = "Date(#{self.table_name}.created_at)"
      totals, before_count = self.group(date_created_at).count, self.where(date_created_at + ' < ?', since.to_date).count
      # TODO separate MySQL/Postgres approaches using ActiveRecord::Base.connection.adapter_name or check hash key is_a? String/Date
      (since.to_date..Date.today).each_with_object([]) { |day, a| a << (a.last || before_count) + (totals[day] || totals[day.to_s] || 0) }
    end

    def delta_records_since(since = 30.days.ago)
      date_created_at = "Date(#{self.table_name}.created_at)"
      deltas = self.group(date_created_at).count

      (since.to_date..Date.today).map { |date| deltas[date] ||  deltas[date.to_s] || 0 }
    end

    def graph_data(since=30.days.ago)
      [[
          {
              name: model_name.plural,
              pointInterval: 1.day * 1000,
              pointStart: since.to_i * 1000,
              data: self.total_records_since(since)
          }
      ]]
    end

    def xaxis
      ["datetime"]
    end

    def label_rotation
      ["0"]
    end

    def chart_type
      [""]
    end
  end
end

#require 'rails_admin/config/actions'
require 'rails_admin_charts/rails_admin/config/actions/charts'
