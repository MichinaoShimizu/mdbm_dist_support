require "spec_helper"

RSpec.describe MdbmDistSupport do
  it 'has a version number' do
    expect(MdbmDistSupport::VERSION).not_to be nil
  end

  it 'MdbmDistSupport::Validator::valid_run_dist_settings? success case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?(MdbmDistSupport::Validator::RUN_DIST_REQUIRE_INSTANCE_VARS)).to eq(true)
  end

  it 'MdbmDistSupport::Validator::valid_run_dist_settings? failure case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?([:@lock_path])).to eq(false)
  end

  it 'MdbmDistSupport::Validator::valid_run_print_after_settings? success case' do
    expect(MdbmDistSupport::Validator::valid_run_print_after_settings?(MdbmDistSupport::Validator::RUN_PRINT_AFTER_REQUIRE_INSTANCE_VARS)).to eq(true)
  end

  it 'MdbmDistSupport::Validator::valid_run_print_after_settings? failure case' do
    expect(MdbmDistSupport::Validator::valid_run_dist_settings?([:@lock_path])).to eq(false)
  end
end
