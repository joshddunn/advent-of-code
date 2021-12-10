require_relative '../../../2021/4/solution'

RSpec.describe '4' do
  it 'example one' do
    expect(solution('example.txt')).to eq(4512)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(28082)
  end

  it 'example one' do
    expect(solution('example.txt', false)).to eq(1924)
  end

  it 'part two' do
    expect(solution('input.txt', false)).to eq(8224)
  end
end
