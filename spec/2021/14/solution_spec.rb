require_relative '../../../2021/14/solution'

RSpec.describe '14' do
  it 'example one' do
    expect(solution('example.txt')).to eq(1588)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(3406)
  end

  it 'example one' do
    expect(solution('example.txt', 40)).to eq(2188189693529)
  end

  it 'part two' do
    expect(solution('input.txt', 40)).to eq(3941782230241)
  end
end
