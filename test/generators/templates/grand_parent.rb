class GrandParent < ActiveRecord::Base
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
  column :company_catch_phrase, :text
  column :company_bullshit, :text
  
  has_many :parents
end
