require_relative '../../6/solution'

RSpec.describe '6' do
  it 'example one' do
    expect(solution('example.txt', 80)).to eq(5934)
  end

  it 'part one' do
    expect(solution('input.txt', 80)).to eq(387413)
  end

  it 'example one' do
    expect(solution('example.txt', 256)).to eq(26984457539)
  end

  it 'part two' do
    expect(solution('input.txt', 256)).to eq(1738377086345)
  end

  it 'golf example one' do
    expect(solution_golf('example.txt', 80)).to eq(5934)
  end

  it 'golf part one' do
    expect(solution_golf('input.txt', 80)).to eq(387413)
  end

  it 'golf example one' do
    expect(solution_golf('example.txt', 256)).to eq(26984457539)
  end

  it 'golf part two' do
    expect(solution_golf('input.txt', 256)).to eq(1738377086345)
  end
end
