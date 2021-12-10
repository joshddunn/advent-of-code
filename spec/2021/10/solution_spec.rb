require_relative '../../../2021/10/solution'

RSpec.describe '10' do
  it 'example one' do
    expect(solution('example.txt')).to eq(26397)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(311895)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(288957)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(2904180541)
  end
end
