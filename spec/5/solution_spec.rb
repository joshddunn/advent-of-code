require_relative '../../5/solution'

RSpec.describe '5' do
  it 'example one' do
    expect(solution('example.txt')).to eq(5)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(7297)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(12)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(21038)
  end
end
