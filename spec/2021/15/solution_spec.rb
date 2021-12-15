require_relative '../../../2021/15/solution'

RSpec.describe '15' do
  it 'example one' do
    expect(solution('example.txt')).to eq(40)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(592)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(315)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(2897)
  end
end
