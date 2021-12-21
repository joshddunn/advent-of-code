require_relative '../../../2021/21/solution'

RSpec.describe '21' do
  it 'example one' do
    expect(solution('example.txt')).to eq(739785)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(797160)
  end

  it 'example one' do
    expect(solution_two(4, 8)).to eq(444356092776315)
  end

  it 'part two' do
    expect(solution_two(2, 1)).to eq(27464148626406)
  end
end
