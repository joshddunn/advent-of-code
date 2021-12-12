require_relative '../../../2021/12/solution'

RSpec.describe '12' do
  it 'example one' do
    expect(solution('example.txt')).to eq(10)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(4691)
  end

  it 'example one' do
    expect(solution('example.txt', true)).to eq(36)
  end

  it 'part two' do
    expect(solution('input.txt', true)).to eq(140718)
  end
end
