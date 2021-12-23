require_relative '../../../2021/23/solution'

RSpec.describe '23' do
  it 'part one' do
    caves = [
      ["D", "D"],
      ["C", "A"],
      ["B", "C"],
      ["B", "A"]
    ]
    expect(solution(caves)).to eq(19167)
  end

  it 'part two' do
    caves = [
      ["D", "D", "D", "D"],
      ["C", "B", "C", "A"],
      ["B", "A", "B", "C"],
      ["B", "C", "A", "A"]
    ]
    expect(solution(caves)).to eq(47665)
  end
end
