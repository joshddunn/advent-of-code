require_relative '../../../2021/25/solution'

RSpec.describe '25' do
  it 'example one' do
    expect(solution('example.txt')).to eq(58)
  end

  it 'part one' do
    expect(solution('input.txt')).to eq(334)
  end
end
