require_relative '../../../2021/20/solution'

RSpec.describe '20' do
  it 'example one' do
    expect(solution('example.txt')).to eq(35)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(5203)
  end

  it 'example one' do
    expect(solution('example.txt', 50)).to eq(3351)
  end

  it 'part two' do
    expect(solution('input.txt', 50)).to eq(18806)
  end
end
