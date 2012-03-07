parsed_json = {
  "benchmark": {
    "name":  "Benchmark 1",
    "param": "benchmark_1",
    "units": "MB"
  },
  "results": [
    {
      "time_str":     "2012-01-12 07:23:49 UTC",
      "rvm_name":     "1.8.7",
      "result":       56.6861324310303,
      "full_version": "ruby 1.8.7 (2011-06-30 patchlevel 352) [i686-darwin10.8.0]"
    },
    {
      "time_str":     "2012-01-12 08:55:44 UTC",
      "rvm_name":     "jruby-head",
      "result":       208.656998634338,
      "full_version": "jruby 1.7.0.dev (ruby-1.8.7-p357) (2012-01-12 0e83d96) (Java HotSpot(TM) 64-Bit Server VM 1.6.0_29) [darwin-x86_64-java]"
    },
    {
      "time_str":     "2012-02-14 07:15:35 UTC",
      "rvm_name":     "jruby-head",
      "result":       209.65935277938843,
      "full_version": "jruby 1.7.0.dev (ruby-1.9.3-p28) (2012-02-14 c867d1f) (Java HotSpot(TM) 64-Bit Server VM 1.6.0_29) [darwin-x86_64-java]"
    }
  ]
}

describe "BenchmarkFlotter", ->
  it "takes a url", ->
    benchmark_flotter = new BenchmarkFlotter parsed_json

  it "makes tabular, flottable data", ->
    benchmark_flotter = new BenchmarkFlotter parsed_json
    expect(benchmark_flotter.flotData().length).toEqual(2)
    expect(benchmark_flotter.flotData()[0]['label']).toBeDefined()
    expect(benchmark_flotter.flotData()[0]['data']).toBeDefined()
    expect(benchmark_flotter.flotData()[0]['data'].length).toBeDefined()

  it "makes the correct flottable data", ->
    benchmark_flotter = new BenchmarkFlotter parsed_json
    expect(benchmark_flotter.flotData()).toEqual([
      {
        label: "1.8.7",
        data: [["2012-01-12 07:23:49 UTC", 56.6861324310303]]
      },
      {
        label: "jruby-head",
        data: [["2012-01-12 08:55:44 UTC", 208.656998634338], ["2012-02-14 07:15:35 UTC", 209.65935277938843]]
      }
    ])