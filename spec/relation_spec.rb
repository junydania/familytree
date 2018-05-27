require 'relation'
require 'family_tree'
require 'family'

describe 'Relation' do

    describe 'relationships' do

        it 'checks if person has sons' do
            input = [["Person", "Alex"],["Relation", "Sons"]]
            expected_array = ["Jacob", "Shaun"]
            APP_ROOT = File.dirname(__FILE__)
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_sons).to eq(expected_array)
        end

        it 'checks if person has daughters' do
            input = [["Person", "Joe"],["Relation", "Daughters"]]
            expected_array = ["Sally"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_daughters).to eq(expected_array)
        end

        it 'checks if person has brothers' do
            input = [["Person", "Alex"],["Relation", "Brothers"]]
            expected_array = ["John", "Joe"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_brothers).to eq(expected_array)
        end

        it 'checks if person has sisters' do
            input = [["Person", "Alex"],["Relation", "Sisters"]]
            expected_array = ["Nisha"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_sisters).to eq(expected_array)
        end

        it 'checks if person has father' do
            input = [["Person", "Alex"],["Relation", "Father"]]
            expected_array = "Evan"
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_father).to eq(expected_array)
        end

        it 'checks if person has mother' do
            input = [["Person", "Alex"],["Relation", "Mother"]]
            expected_array = "Diana"
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_mother).to eq(expected_array)
        end

        it 'checks if person has cousins' do
            input = [["Person", "Jacob"],["Relation", "Cousins"]]
            expected_array = ["Shaun", "Piers", "Sally", "Ruth", "William", "Paul"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_cousins).to eq(expected_array)
        end

        it 'checks if person has aunts' do
            input = [["Person", "Jacob"],["Relation", "Aunts"]]
            expected_array = ["Nisha"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_aunts).to eq(expected_array)
        end

        it 'checks if person has uncles' do
            input = [["Person", "Jacob"],["Relation", "Uncles"]]
            expected_array = ["John", "Alex", "Joe"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_uncles).to eq(expected_array)
        end

        it 'checks if person has grandfather' do
            input = [["Person", "Piers"],["Relation", "Grandfather"]]
            expected_array = "Evan"
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_grandfather).to eq(expected_array)
        end

        it 'checks if person has grandmother' do
            input = [["Person", "Piers"],["Relation", "Grandmother"]]
            expected_array = "Diana"
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_grandmother).to eq(expected_array)
        end

        it 'checks if person has grandsons' do
            input = [["Person", "Evan"],["Relation", "Grandsons"]]
            expected_array = ["Jacob", "Shaun", "Piers", "William", "Paul"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_grandsons).to eq(expected_array)
        end

        it 'checks if person has granddaughters' do
            input = [["Person", "Evan"],["Relation", "Granddaughters"]]
            expected_array = ["Sally", "Ruth"]
            FamilyTree.new('family.yml')
            @person_relation = Relation.new(input)
            expect(@person_relation.has_granddaughters).to eq(expected_array)
        end

    end
    
end
