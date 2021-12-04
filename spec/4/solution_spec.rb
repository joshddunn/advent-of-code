require_relative '../../4/solution'

RSpec.describe '4' do
  it 'example one' do
    expect(part_one('example.txt')).to eq(4512)
  end

  it 'part one' do
    expect(part_one('input.txt')).to eq(28082)
  end

  it 'example one' do
    expect(part_two('example.txt')).to eq(1924)
  end

  it 'part two' do
    expect(part_two('input.txt')).to eq(8224)
  end
end
