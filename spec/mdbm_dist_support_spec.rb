require "spec_helper"

RSpec.describe MdbmDistSupport do
  it 'has a version number' do
    expect(MdbmDistSupport::VERSION).not_to be nil
  end
end

RSpec.describe MdbmDistSupport::Validator do
  it 'MdbmDistSupport::Validator::valid_run_dist_settings? valid case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?(MdbmDistSupport::Validator::RUN_DIST_REQUIRE_INSTANCE_VARS)).to eq(true)
  end

  it 'MdbmDistSupport::Validator::valid_run_dist_settings? invalid case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?([:@lock_path])).to eq(false)
  end

  it 'MdbmDistSupport::Validator::valid_run_print_after_settings? valid case' do
    expect(MdbmDistSupport::Validator::valid_run_print_after_settings?(MdbmDistSupport::Validator::RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS)).to eq(true)
  end

  it 'MdbmDistSupport::Validator::valid_run_print_after_settings? invalid case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?([:@lock_path])).to eq(false)
  end
end

RSpec.describe MdbmDistSupport::Lock do
  before do
    @path = '/tmp/UT-MdbmDistSupport.lck'
  end

  after do
    File.unlink @path
  end

  it 'MdbmDistSupport::Lock::try_lock success case' do
    expect(MdbmDistSupport::Lock.new(@path).try_lock).to eq(true)
  end

  it 'MdbmDistSupport::Lock::try_lock duplicate lock case' do
    path = '/tmp/UT-MdbmDistSupport.lck'
    MdbmDistSupport::Lock.new(@path).try_lock
    expect(MdbmDistSupport::Lock.new(@path).try_lock).to eq(false)
  end
end

RSpec.describe MdbmDistSupport::Meta do
  before do
    @path = '/tmp/UT-MdbmDistSupport.meta'
  end

  after do
    File.unlink @path
  end

  it 'MdbmDistSupport::Meta::fetch string case' do
    meta = MdbmDistSupport::Meta.new @path
    meta.store('hoge', 'fuga')
    expect(meta.fetch('hoge')).to eq('fuga')
  end

  it 'MdbmDistSupport::Meta::fetch nil case' do
    meta = MdbmDistSupport::Meta.new @path
    expect(meta.fetch('fuga')).to eq(nil)
  end

  it 'MdbmDistSUpport::MEta::store string case save string' do
    meta = MdbmDistSupport::Meta.new @path
    meta.store('hoge', 'fuga')
    expect(meta.fetch('hoge').class).to eq(String)
  end

  it 'MdbmDistSUpport::MEta::store nil case save string' do
    meta = MdbmDistSupport::Meta.new @path
    meta.store('hoge', nil)
    expect(meta.fetch('hoge').class).to eq(String)
  end

  it 'MdbmDistSUpport::MEta::store time case save string' do
    meta = MdbmDistSupport::Meta.new @path
    meta.store('hoge', Time.new)
    expect(meta.fetch('hoge').class).to eq(String)
  end
end
