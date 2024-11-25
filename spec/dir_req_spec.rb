RSpec.describe DirReq do
  it 'has a version number' do
    expect(DirReq::VERSION).not_to be_nil
  end

  it 'loads files from a directory' do
    expect(DirReq.require_directory).not_to be_nil
  end
end
