require_relative '../../2/solution'

RSpec.describe '2' do
  it 'example one' do
    expect(dive_one('example.txt')).to eq(150)
  end

  it 'part one' do
    expect(dive_one('input.txt')).to eq(1_654_760)
  end

  it 'example one' do
    expect(dive_two('example.txt')).to eq(900)
  end

  it 'part two' do
    expect(dive_two('input.txt')).to eq(1_956_047_400)
  end
end
