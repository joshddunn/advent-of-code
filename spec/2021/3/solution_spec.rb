require_relative '../../../2021/3/solution'

RSpec.describe '3' do
  it 'example one' do
    expect(diagnostic_one('example.txt')).to eq(198)
  end

  it 'part one' do
    expect(diagnostic_one('input.txt')).to eq(1_997_414)
  end

  it 'example one' do
    expect(diagnostic_two('example.txt')).to eq(230)
  end

  it 'part two' do
    expect(diagnostic_two('input.txt')).to eq(1_032_597)
  end
end
