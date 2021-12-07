require_relative '../../7/solution'

RSpec.describe '7' do
  it 'example one' do
    expect(solution('example.txt')).to eq(37)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(331067)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(168)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(92881128)
  end
end
