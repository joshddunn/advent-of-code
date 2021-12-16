require_relative '../../../2021/16/solution'

RSpec.describe '16' do
  it 'example one' do
    expect(solution('example.txt', :version_sum)).to eq([16, 12, 23, 31])
  end

  it 'part one' do
    expect(solution('input.txt', :version_sum)).to eq([1012])
  end

  it 'example one' do
    expect(solution('example_two.txt', :value)).to eq([3, 54, 7, 9, 1, 0, 0, 1])
  end

  it 'part two' do
    expect(solution('input.txt', :value)).to eq([2223947372407])
  end
end
