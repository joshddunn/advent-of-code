require_relative '../../../2021/24/solution'

RSpec.describe '24' do
  it 'part one' do
    expect(solution('input.txt', :>)).to eq(51983999947999)
  end

  it 'part two' do
    expect(solution('input.txt', :<)).to eq(11211791111365)
  end
end
