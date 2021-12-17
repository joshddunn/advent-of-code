require_relative '../../../2021/17/solution'

RSpec.describe '17' do
  it 'example one' do
    expect(solution('example.txt')).to eq(45)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(5778)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(112)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(2576)
  end
end
