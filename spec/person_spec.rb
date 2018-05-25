require 'person'

describe 'Person' do

    describe 'attributes' do
        before do
            @person = Person.new("Osegbemoh", "Male")
        end
        
        it 'allows writing for :name' do
            @person.name = "Tobias-David"
            expect(@person.name).to eq("Tobias-David")
        end

        it 'allows writing for :sex' do
            @person.sex = "Female"
            expect(@person.sex).to eq("Female")
        end
    end
    
end

