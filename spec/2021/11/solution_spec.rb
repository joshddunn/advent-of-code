require_relative '../../../2021/11/solution'

RSpec.describe '11' do
  it 'example one' do
    expect(solution('example.txt')).to eq(1656)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(1642)
  end

  it 'example one' do
    expect(solution('example.txt', Float::INFINITY)).to eq(195)
  end

  it 'part two' do
    expect(solution('input.txt', Float::INFINITY)).to eq(320)
  end
end
