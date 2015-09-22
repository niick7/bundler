require "spec_helper"

describe "bundle cache" do
  before do
    gemfile <<-G
      source "file://#{gem_repo1}"
      gem "rack"
    G
  end

  context "with --cache-path" do
    it "caches gems at given path" do
      bundle :cache, "cache-path" => "vendor/cache-foo"
      expect(bundled_app("vendor/cache-foo/rack-1.0.0.gem")).to exist
    end
  end

  context "with config cache_path" do
    it "caches gems at given path" do
      bundle "config cache_path vendor/cache-foo"
      bundle :cache
      expect(bundled_app("vendor/cache-foo/rack-1.0.0.gem")).to exist
    end
  end

  context "when given an absolute path" do
    it "exits with non-zero status" do
      bundle :cache, "cache-path" => "/tmp/cache-foo"
      expect(err).to match(/must be relative/)
      expect(exitstatus).to eq(15) if exitstatus
    end
  end
end
