#### Family Tree Finder #####


APP_ROOT = File.dirname(__FILE__)

#require = "#{APP_ROOT}/lib/guide"
#require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift(File.join(APP_ROOT, 'lib'))

require 'family_tree'

tree = FamilyTree.new('family.yml')

tree.launch!
