require 'rspec'
require './lib/patron'

describe Patron do
    let(:patron_1){Patron.new("Bob", 20)}

    it 'exists' do
        expect(patron_1).to be_an_instance_of(Patron)
    end

    it 'has redable attributes' do
        expect(patron_1.name).to eq("Bob")
        expect(patron_1.spending_money).to eq(20)
        expect(patron_1.interests).to eq([])
    end

    it 'can add interests' do
        patron_1.add_interest("Dead Sea Scrolls")
        patron_1.add_interest("Gems and Minerals")
        
        expect(patron_1.interests).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
    end
end