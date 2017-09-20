require "spec_helper"

describe MdbmDistSupport::Validator do
  subject { MdbmDistSupport::Validator }
  describe 'valid_run_dist_settings?()' do
    context 'case: all of require instance variables exist' do
      it 'valid. return true' do
        expect(subject.valid_run_dist_settings?(subject::RUN_DIST_REQUIRE_INSTANCE_VARS)).to eq(true)
      end
    end

    context 'case: some of require instance variables not exist' do
      it 'invalid. return false' do
        expect(subject.valid_run_dist_settings?([:@lock_path])).to eq(false)
      end
    end
  end

  describe 'valid_run_print_after_settings?()' do
    context 'case: all of require instance variables exist' do
      it 'valid. return true' do
        expect(subject.valid_run_print_after_settings?(subject::RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS)).to eq(true)
      end
    end

    context 'case: some of require instance variables not exist' do
      it 'invalid. return false' do
        expect(subject.valid_run_dist_settings?([:@lock_path])).to eq(false)
      end
    end
  end
end

describe MdbmDistSupport::Lock do
  subject { MdbmDistSupport::Lock }
  before do
    @path = '/tmp/UT-MdbmDistSupport.lck'
  end

  after do
    File.unlink @path
  end

  describe 'try_lock()' do
    context 'case: single proc call' do
      it 'no error. return true' do
        expect(subject.new(@path).try_lock).to eq(true)
      end
    end

    context 'case: 2 proc open call' do
      it 'cannot get lock. return false' do
        subject.new(@path).try_lock
        expect(subject.new(@path).try_lock).to eq(false)
      end
    end
  end
end

describe MdbmDistSupport::Meta do
  subject { MdbmDistSupport::Meta }
  before do
    @path = '/tmp/UT-MdbmDistSupport.meta'
  end

  after do
    File.unlink @path
  end

  describe 'fetch()' do
    context 'case: key exist' do
      it 'return setted string object' do
        meta = subject.new @path
        meta.store('hoge', 'fuga')
        expect(meta.fetch('hoge')).to eq('fuga')
      end
    end

    context 'case: key not exist' do
      it 'return nil' do
        meta = subject.new @path
        expect(meta.fetch('hoge')).to eq(nil)
      end
    end
  end
end
