require('spec_helper')

describe(Train) do
  describe('.all') do
    it("returns an empty list of trains at first") do
    expect(Train.all()).to(eq([]))
    end
  end

end
