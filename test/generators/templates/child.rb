class Child < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :name, :string
  column :email, :string
  column :moto, :text
  column :address, :string
  column :latitude, :float
  column :longitude, :float
  column :friends, :integer
  column :birth_data, :date
  column :parent_id, :integer
  
  belongs_to :parent
end
