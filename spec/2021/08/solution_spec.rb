require_relative '../../../2021/8/solution'

RSpec.describe '8' do
  it 'example one' do
    expect(solution('example.txt')).to eq(26)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(525)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(61229)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(1083859)
  end
end
