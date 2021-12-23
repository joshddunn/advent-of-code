require_relative '../../../2021/22/solution'

RSpec.describe '22' do
  it 'example one' do
    expect(solution('example.txt', 50)).to eq(39)
  end

  it 'example two' do
    expect(solution('example_two.txt', 50)).to eq(590784)
  end

  it 'part one' do
    expect(solution('input.txt', 50)).to eq(596598)
  end

  it 'example three' do
    expect(solution('example_three.txt')).to eq(2758514936282235)
  end

  it 'part two' do
    expect(solution('input.txt')).to eq(1199121349148621)
  end
end
