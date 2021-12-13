require_relative '../../../2021/13/solution'

RSpec.describe '13' do
  it 'example one' do
    expect(solution('example.txt', 1)[:points].count).to eq(17)
  end

  it 'part one' do
    expect(solution('input.txt', 1)[:points].count).to eq(712)
  end

  it 'example one' do
    expect(solution('example.txt')[:array]).to eq([[1, 1, 1, 1, 1], [1, nil, nil, nil, 1], [1, nil, nil, nil, 1], [1, nil, nil, nil, 1], [1, 1, 1, 1, 1]])
  end

  it 'part two' do
    expect(solution('input.txt')[:array]).to eq([[1, 1, 1, nil, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, 1, 1, 1, nil, nil, nil, 1, 1, nil, 1, 1, 1, nil, nil, nil, nil, 1, 1, nil, 1, 1, 1, 1],
 [1, nil, nil, 1, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil, nil, nil, nil, nil, 1, nil, 1, nil, nil, 1, nil, nil, nil, nil, 1, nil, 1, nil, nil, nil],
 [1, 1, 1, nil, nil, 1, nil, nil, nil, nil, 1, 1, 1, 1, nil, 1, 1, 1, nil, nil, nil, nil, nil, 1, nil, 1, nil, nil, 1, nil, nil, nil, nil, 1, nil, 1, 1, 1, nil],
 [1, nil, nil, 1, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil, nil, nil, nil, nil, 1, nil, 1, 1, 1, nil, nil, nil, nil, nil, 1, nil, 1, nil, nil, nil],
 [1, nil, nil, 1, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil],
 [1, 1, 1, nil, nil, 1, 1, 1, 1, nil, 1, nil, nil, 1, nil, 1, nil, nil, nil, nil, nil, 1, 1, nil, nil, 1, nil, nil, nil, nil, nil, 1, 1, nil, nil, 1, nil, nil, nil]])
  end
end
