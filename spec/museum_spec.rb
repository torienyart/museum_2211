require 'rspec'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

describe Museum do
	let(:dmns){Museum.new("Denver Museum of Nature and Science")}
	let(:gems_and_minerals){Exhibit.new({name: "Gems and Minerals", cost: 0})}
	let(:dead_sea_scrolls){Exhibit.new({name: "Dead Sea Scrolls", cost: 10})}
	let(:imax){Exhibit.new({name: "IMAX",cost: 15})}

	describe 'setup' do

		it 'exists' do
			expect(dmns).to be_an_instance_of(Museum)
		end

		it 'has readable attributes' do
			expect(dmns.exhibits).to eq([])
			expect(dmns.name).to eq("Denver Museum of Nature and Science")
			expect(dmns.patrons).to eq([])
		end

	end


	describe 'exhibits' do
		let(:patron_1){Patron.new("Bob", 20)}
		let(:patron_2){Patron.new("Sally", 20)}
		let(:patron_3){Patron.new("Johnny", 5)}

		before(:each) do
			dmns.add_exhibit(gems_and_minerals)
			dmns.add_exhibit(dead_sea_scrolls)
			dmns.add_exhibit(imax)
			patron_1.add_interest("Dead Sea Scrolls")
			patron_1.add_interest("Gems and Minerals")
			patron_2.add_interest("IMAX")
		end

		it 'can add exhibits' do
			expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
		end

		it 'can recommend exhibits' do
			expect(dmns.recommend_exhibits(patron_1)).to eq([dead_sea_scrolls, gems_and_minerals])
			expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
		end

	end

	describe 'patrons' do
		let(:patron_1){Patron.new("Bob", 0)}
		let(:patron_2){Patron.new("Sally", 20)}
		let(:patron_3){Patron.new("Johnny", 5)}
		
		before(:each) do
			dmns.add_exhibit(gems_and_minerals)
			dmns.add_exhibit(dead_sea_scrolls)
			dmns.add_exhibit(imax)
			patron_1.add_interest("Gems and Minerals")
			patron_1.add_interest("Dead Sea Scrolls")
			patron_2.add_interest("Dead Sea Scrolls")
			patron_3.add_interest("Dead Sea Scrolls")
			dmns.admit(patron_1)
			dmns.admit(patron_2)
			dmns.admit(patron_3)
		end

		it 'can admit patrons' do
			expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
		end

		it 'can group patrons by interest' do
			expect(dmns.patrons_by_exhibit_interest).to eq({
				gems_and_minerals => [patron_1],
				dead_sea_scrolls => [patron_1, patron_2, patron_3],
				imax => []
			})
		end

		it 'can determine ticket lottery' do
			expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
			expect(dmns.ticket_lottery_contestants(gems_and_minerals)).to eq([])
		end

		it 'can draw a lottery winner' do
			
			expect(["Bob", "Johnny"]).to include(dmns.draw_lottery_winner(dead_sea_scrolls))
			expect(dmns.draw_lottery_winner(gems_and_minerals)).to eq(nil)

		end

		it 'can announce a lottery winner' do 
			allow(dmns.announce_lottery_winner(imax)).to receive(:draw_lotter_winner).and_return("Bob has won the IMAX exhibit lottery")

			expect(dmns.announce_lottery_winner(gems_and_minerals)).to eq("No winners for this lottery")
		end
	end

	
end
