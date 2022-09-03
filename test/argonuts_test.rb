$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "..", "lib"))

require "test/unit"
require "argonuts-ruby"

class ArgonutsTest < Test::Unit::TestCase
  INPUT_URL = "https://argonuts.co/sample1080p.mp4"

  def setup
    Argonuts.api_key = ENV["ARGONUTS_API_KEY"]
    Argonuts.endpoint = ENV["ARGONUTS_ENDPOINT"]

    Argonuts.notification = {
      type: "http",
      url: ENV["ARGONUTS_WEBHOOK_URL"]
    }

    Argonuts.storage = {
      url: ENV["ARGONUTS_STORAGE_URL"],
    }
  end

  def create_job(j={}, options={})
    Argonuts::Job.create({
      input: { url: INPUT_URL },
      outputs: {
        mp4: { path: "/test_create_job.mp4" }
      }
    }.merge(j), options)
  end

  def test_argonuts_api_key
    Argonuts.api_key = "apikey"
    assert "apikey", Argonuts.api_key
  end

  def test_argonuts_default_endpoint
    assert "https://argonuts.co/api/v1", Argonuts.endpoint
  end

  def test_overwrite_endpoint
    myendpoint = "https://argonuts.local/api/v1"
    Argonuts.endpoint = myendpoint

    assert myendpoint, Argonuts.endpoint
  end

  def test_create_job
    job = create_job
    assert job.is_a?(Argonuts::Job)
    assert_not_nil job.id
    assert_equal "job.starting", job.status
  end

  def test_retrieve_job
    job = Argonuts::Job.retrieve(create_job.id)
    assert job.is_a?(Argonuts::Job)
    assert_not_nil job.id
    assert_equal "job.starting", job.status
  end

  # def test_create_job_error
  #   create_job(input: {url: "notvalidurl"})
  # rescue => e
  #   assert_equal e.class, Argonuts::Error
  # end
  #
  # def test_retrieve_metadata
  #   job = create_job
  #   sleep 10
  #
  #   md = Argonuts::Metadata.retrieve(job.id)
  #   assert md.is_a?(Hash)
  #   assert_not_nil md["metadata"]["input"]
  # end
end
