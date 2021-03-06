#### Family Tree Finder #####

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))

require 'family_tree'

tree = FamilyTree.new("data/family.yml")

tree.launch!
