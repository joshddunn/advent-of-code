require_relative '../../1/solution'

RSpec.describe '1' do
  it 'example one' do
    expect(sonar_sweep('example.txt')).to eq(7)
  end

  it 'part one' do
    expect(sonar_sweep('input.txt')).to eq(1583)
  end

  it 'example two' do
    expect(sonar_sweep('example.txt', 3)).to eq(5)
  end

  it 'part two' do
    expect(sonar_sweep('input.txt', 3)).to eq(1627)
  end
end
