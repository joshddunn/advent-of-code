require_relative '../../6/solution'

RSpec.describe '6' do
  it 'example one' do
    expect(part_one('example.txt')).to eq(0)
  end

  it 'part one' do
    expect(part_one('input.txt')).to eq(0)
  end

  it 'example one' do
    expect(part_two('example.txt', true)).to eq(0)
  end

  it 'part two' do
    expect(part_two('input.txt', true)).to eq(0)
  end
end
