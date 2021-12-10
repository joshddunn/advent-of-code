require_relative '../../../2021/9/solution'

RSpec.describe '9' do
  it 'example one' do
    expect(solution('example.txt')).to eq(15)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(423)
  end

  it 'example one' do
    expect(solution_two('example.txt')).to eq(1134)
  end

  it 'part two' do
    expect(solution_two('input.txt')).to eq(1198704)
  end
end
