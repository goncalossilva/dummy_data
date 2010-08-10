require File.expand_path("../test_helper", File.dirname(__FILE__))

class DummyDataGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Dummy::Generators::DataGenerator
  arguments []

  setup :create_test_application
  teardown :clean_tmp

  test "dummy generates files with correct amount using default and user-defined options" do
    run_generator
    
    ["children", "parents", "grand_parents"].each do |model|
      assert_file "test/dummy/data/#{model}.yml"
    end
    assert_file "lib/tasks/dummy_data.rake"
    assert_file "test/dummy/Dummyfile"
    
    all_options = {%w()    => [{:n => "children", :a => "40"}, 
                              {:n => "parents", :a => "20"}, 
                              {:n => "grand_parents", :a => "10"}],
    %w(--growth-ratio=3.0) => [{:n => "children", :a => "90"}, 
                              {:n => "parents", :a => "30"}, 
                              {:n => "grand_parents", :a => "10"}],
    %w(--growth-ratio=1.0) => [{:n => "children", :a => "10"}, 
                              {:n => "parents", :a => "10"}, 
                              {:n => "grand_parents", :a => "10"}],
    %w(--base-amount=5)    => [{:n => "children", :a => "20"}, 
                              {:n => "parents", :a => "10"}, 
                              {:n => "grand_parents", :a => "5"}],
    %w(--growth-factor=4.0 --base-amount=2) =>  
                              [{:n => "children", :a => "8"}, 
                              {:n => "parents", :a => "4"}, 
                              {:n => "grand_parents", :a => "2"}],
    %w(--output-folder test/dummy_dinassour) =>
                              [{:n => "children", :a => "40", :f => "test/dummy_dinassour"},
                              {:n => "parents", :a => "20", :f => "test/dummy_dinassour"}, 
                              {:n => "grand_parents", :a => "10", :f => "test/dummy_dinassour"}]}
    
    all_options.each do |options, results|
      clean_dummy
      run_generator options
      
      results.each do |data|
        folder = data[:f] || "test/dummy"
        header_line = File.read("#{folder}/data/#{data[:n]}.yml").match(/([^\n]+)/)[0]
        assert_nil header_line.index("\n")
        
        regex = /# '(\w+)' data generated automatically by dummy at .+ \((\d+) records\)\./
        results = header_line.match(regex)

        assert_equal data[:n], results[1]
        assert_equal data[:a], results[2]
      end
    end
  end
end

