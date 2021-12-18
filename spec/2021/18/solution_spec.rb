require_relative '../../../2021/18/solution'

RSpec.describe '18' do
  it 'example one' do
    expect(solution('example.txt')).to eq(4140)
  end

  it 'example one sums' do
    expect(solution_sums('example_sums.txt')).to eq([143, 1384, 445, 791, 1137, 3488])
  end

  it 'example one reduce' do
    expect(solution('example_reduce.txt')).to eq(3488)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(4435)
  end

  it 'example two' do
    expect(solution_magnitude('example.txt')).to eq(3993)
  end

  it 'part two' do
    expect(solution_magnitude('input.txt')).to eq(4802)
  end
end
