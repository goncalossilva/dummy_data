class Parent < ActiveRecord::Base
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :name, :string
  column :email, :string
  column :catch_phrase, :text
  column :address, :string
  column :latitude, :float
  column :longitude, :float
  column :birth_data, :date
  column :company, :string
  column :grand_parent_id, :integer
  
  belongs_to :grand_parent
  has_many :children
end
