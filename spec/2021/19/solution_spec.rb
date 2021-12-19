require_relative '../../../2021/19/solution'

RSpec.describe '19' do
  it 'example one' do
    expect(solution('example.txt')[:beacons_count]).to eq(79)
  end

  it 'part one' do
    expect(solution('input.txt')[:beacons_count]).to eq(440)
  end

  it 'example one' do
    expect(solution('example.txt')[:max_manhattan]).to eq(3621)
  end

  it 'part two' do
    expect(solution('input.txt')[:max_manhattan]).to eq(13382)
  end
end
