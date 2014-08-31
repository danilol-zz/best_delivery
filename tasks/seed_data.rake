# -*- encoding : utf-8 -*-
namespace :db do
  desc "Create all data"
  task :seed  do
    $: << File.join(File.dirname(__FILE__), '..', '..')
    require File.join(File.dirname(__FILE__), '..', 'best_delivery')

    load 'db/seeds.rb'
  end
end
